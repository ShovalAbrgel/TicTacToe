exports.checkWin = (board) => {
    const winningCombos = [
      // Rows
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      // Columns
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      // Diagonals
      [0, 4, 8],
      [2, 4, 6],
    ];
  
    for (const combo of winningCombos) {
      const [a, b, c] = combo;
      if (board[a] !== 0 && board[a] === board[b] && board[a] === board[c]) {
        return true;
      }
    }
  
    return false;
  };
  