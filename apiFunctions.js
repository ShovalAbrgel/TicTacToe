let st = require('./server_tools');
let tac = require('./tic_tac_toe');

function checkUsernameAndPassword(q) {
    let username = q.query.username;
    let password = q.query.password;
    if(!username || !password){
      return false;
    }
    return true;
  }

exports.signup = (req,res,q)=>{
    let username = q.query.username;
    let password = q.query.password;
    if (!checkUsernameAndPassword(q)) {
        res.writeHead(400, {'Content-Type': 'text/plain'});
        res.end();
        return;
      }      
    st.query("INSERT INTO users(username,password) VALUES (?,?)",[username,password],(result,err)=>{
        if(err){
            res.writeHead(200, {'Content-Type':'text/plain'});
            res.end("taken");
            return;
        }
        res.writeHead(200, {'Content-Type':'text/plain'});
        res.end("ok");
    });
};


exports.login = (req,res,q)=>{
    let username = q.query.username;
    let password = q.query.password;
    if (!checkUsernameAndPassword(q)) {
        res.writeHead(400, {'Content-Type': 'text/plain'});
        res.end();
        return;
      }  
    validateUser(username,password,(isValid)=>{
        res.writeHead(200, {'Content-Type':'text/plain'});
        res.end(isValid ? "ok" : "invalid");
    });
};

exports.lobby = (req,res,q)=>{
    let username = q.query.username;
    let password = q.query.password;
    if (!checkUsernameAndPassword(q)) {
        res.writeHead(400, {'Content-Type': 'text/plain'});
        res.end();
        return;
      }  
    st.query("UPDATE users SET lobby=? WHERE username=? AND NOT lobby=-1", [Date.now(),username], (result,err)=>{
        if(err){
            console.error(err);
            res.status(500).send('Error executing SQL query');
            return;
        }
        st.query("SELECT username FROM users WHERE ? - lobby < 2000",[Date.now()], (result, err)=>{
            if(err){
                console.error(err);
                res.status(500).send('Error executing SQL query');
                return;
            }
            res.writeHead(200, {'Content-Type':'application/json'});
            res.end(JSON.stringify(result));
        });
    });
};

exports.startgame = (req,res,q)=>{
    let username = q.query.username;
    let password = q.query.password;
    if (!checkUsernameAndPassword(q)) {
        res.writeHead(400, {'Content-Type': 'text/plain'});
        res.end();
        return;
      }  
    let partner = q.query.partner;
    if(!partner) return;
    st.query("UPDATE users SET lobby=-1 WHERE username IN (?,?) AND ?-lobby<30000", [username, partner, Date.now()], (result,err)=>{
        if(err){
            console.log(err);
            res.writeHead(500 , {'Content-Type' : 'text/plain'});
            res.end('Error executing SQL query');
            return;
        }
        if(result.affectedRows == 2){
            st.query("INSERT INTO games(player1,player2) VALUES (?,?)", [username, partner], (result, err)=>{
                if(err){
                  res.end("");
                  return;
                }
                res.writeHead(200, {'Content-Type':'text/plain'});
                res.end("ok");
            });
        }else{
            res.writeHead(200, {'Content-Type':'text/plain'});
            res.end("error");
        }
    });
};



exports.getGameId =(req,res,q)=>{
    let username = q.query.username;
    let password = q.query.password;
    if (!checkUsernameAndPassword(q)) {
        res.writeHead(400, {'Content-Type': 'text/plain'});
        res.end();
        return;
      }  
    st.query("SELECT id FROM games WHERE (player1=? OR player2=?) AND active=1",[username, username],(result,err)=>{
        if(err){
            res.end("");
            return;
        }
        if(result.length >=1){
            let gameId = result[0].id;
            res.writeHead(200, {'Content-Type':'text/plain'});
            res.end(gameId + "");
        }else{
            res.writeHead(200, {'Content-Type':'text/plain'});
            res.end("-1");
        }

    });

};

exports.getStatus = (req, res, q) => {
  let username = q.query.username;
  let gameId = q.query.id;
  if (!gameId) return;
  st.query(
    "SELECT player1, player2, active, cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, cell9 , turn , currentPlayer FROM games WHERE id=? AND (player1=? OR player2=?)",
    [gameId, username, username],
    (result, err) => {
      if (err) {
        res.end("");
        return;
      }
      let currentPlayer = result[0].gameTurn == 1 ? result[0].player_1 : result[0].player_2;
      let board = [
        result[0].cell1,
        result[0].cell2,
        result[0].cell3,
        result[0].cell4,
        result[0].cell5,
        result[0].cell6,
        result[0].cell7,
        result[0].cell8,
        result[0].cell9,
      ];

      if (result.length == 1) {
        let gameStatus = {
          id: gameId,
          player1: result[0].player1,
          player2: result[0].player2,
          active: result[0].active[0] == 1,
          board: board,
          gameTurn: result[0].gameTurn,
          currentPlayer: currentPlayer,
        };

        // Check if the current move results in a win
        if (tac.checkWin(board)) {
          // Determine the winner
          let winner = board[0] == 1 ? result[0].player1 : result[0].player2;
          gameStatus.winner = winner;
        }

        res.writeHead(200, { "Content-Type": "application/json" });
        res.end(JSON.stringify(gameStatus));
      }
    }
  );
};

 exports.play_TicTacToe = (req, res, q) => {
  let username = q.query.username;
  let cell = q.query.cell;
  let gameId = q.query.id;
  if (cell && gameId) {
    cell = parseInt(cell);
    gameId = parseInt(gameId);
    if (isNaN(cell) || isNaN(gameId)) {
      res.end("");
      return;
    }
    st.query(
      'SELECT player1, player2, cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, cell9, turn, currentPlayer FROM games WHERE id=? AND active=1',
      [gameId],
      (result, err) => {
        if (err) {
          res.end("");
          return;
        }
        if (result.length == 1) {
          let player1 = result[0].player1;
          let player2 = result[0].player2;
          if (player1 == username || player2 == username) {
            let XorO = player1 == username ? 1 : 2;
            let board = [
              result[0].cell1,
              result[0].cell2,
              result[0].cell3,
              result[0].cell4,
              result[0].cell5,
              result[0].cell6,
              result[0].cell7,
              result[0].cell8,
              result[0].cell9,
            ];
            let countX = 0;
            for (let i = 0; i < 9; i++) {
              if (board[i] != 0) countX++;
            }
            let isXturn = countX % 2 == 0;
            if (
              board[cell] == 0 &&
              ((isXturn && XorO == 1) || (!isXturn && XorO == 2))
            ) {
              board[cell] = XorO;
              st.query(
                `UPDATE games SET cell${cell + 1}=${XorO}, turn=${countX + 1}, currentPlayer='${XorO == 1 ? player2 : player1}' WHERE id=?`,
                [gameId],
                (result, err) => {
                  if (err) {
                    res.end("");
                    return;
                  }
                  res.writeHead(200, { "Content-Type": "text/plain" });
                  res.end("ok");
                }
              );
            } else {
              res.writeHead(200, { "Content-Type": "text/plain" });
              res.end("not good");
              return;
            }
          }
        } else {
          res.writeHead(200, { "Content-Type": "text/plain" });
          res.end("ooops");
          return;
        }
      }
    );
  } else {
    res.writeHead(200, { "Content-Type": "text/plain" });
    res.end("");
    return;
  }
};
  
  

exports.leaveGame =(req,res,q)=>{
    let username = q.query.username;
    let password = q.query.password;
    if (!checkUsernameAndPassword(q)) {
        res.writeHead(400, {'Content-Type': 'text/plain'});
        res.end();
        return;
      }  
    st.query("SELECT id,player1,player2 FROM games WHERE (player1=? OR player2=?) AND active=1",[username, username], (result, err)=>{
        if(err){
            res.end("");
            return;
        }
        if(result.length >= 1){
            let gameId = result[0].id;
            let partner;
            if(result[0].player1 == username){
                partner = result[0].player2;
            }else{
                partner = result[0].player1;
            }

            
            st.query("UPDATE games SET active=0 WHERE id=? AND active=1",[gameId],(result,err)=>{
                if(err){
                    res.end("");
                    return;
                }
                if(result.affectedRows == 1){
                    st.query("UPDATE users SET lobby=0 WHERE username IN (?,?)",[username, partner], (result,err)=>{
                        if(err){
                            res.end("");
                            return;
                        }
                        res.writeHead(200, {'Content-Type':'text/plain'});
                        res.end("ok");
                    });
                }else if(result.affectedRows == 0){
                    st.query("UPDATE users SET lobby=0 WHERE username = ?",[username], (result,err)=>{
                        if(err){
                            res.end("");
                            return;
                        }
                        res.writeHead(200, {'Content-Type':'text/plain'});
                        res.end("ok");
                    });
                }
                

            });
            
        }
    });
};


function validateUser(username, password, callback){
    st.query("SELECT COUNT(*) AS count FROM users WHERE username=? AND BINARY password=?", [username, password], (result, err)=>{
        if(err){
            callback(false);
            return;
        }
        callback(result[0].count == 1);
    });
}
