import '../../components/piece.dart';
import '../../constants/icons.dart';

List<List<ChessPiece?>> initializeBoard() {
  List<List<ChessPiece?>> newBoard =
  List.generate(8, (index) => List.generate(8, (index) => null));

  // Place pawns
  for(int i = 0; i < 8; i++){
    newBoard[1][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: false,
        imagePath: BlackPiecePath.pawn
    );
    newBoard[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: true,
        imagePath: WhitePiecePath.pawn);
  }
  // Place rooks
  newBoard[0][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: BlackPiecePath.rook
  );
  newBoard[0][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: BlackPiecePath.rook
  );
  newBoard[7][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: WhitePiecePath.rook
  );
  newBoard[7][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: WhitePiecePath.rook
  );

  // Place knights
  newBoard[0][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: BlackPiecePath.knight
  );
  newBoard[0][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: BlackPiecePath.knight
  );
  newBoard[7][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: WhitePiecePath.knight
  );
  newBoard[7][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: WhitePiecePath.knight
  );

  // Place bishops
  newBoard[0][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: BlackPiecePath.bishop
  );
  newBoard[0][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: BlackPiecePath.bishop
  );
  newBoard[7][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: WhitePiecePath.bishop
  );
  newBoard[7][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: WhitePiecePath.bishop
  );

  // Place queens
  newBoard[0][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: false,
      imagePath: BlackPiecePath.queen
  );
  newBoard[7][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: true,
      imagePath: WhitePiecePath.queen
  );

  // Place kings
  newBoard[0][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: false,
      imagePath: BlackPiecePath.king
  );
  newBoard[7][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: true,
      imagePath: WhitePiecePath.king
  );

  return newBoard;
}
