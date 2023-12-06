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
        imagePath: PieceIcons.pawnB
    );
    newBoard[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: true,
        imagePath: PieceIcons.pawnW);
  }
  // Place rooks
  newBoard[0][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: PieceIcons.rookB
  );
  newBoard[0][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: PieceIcons.rookB
  );
  newBoard[7][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: PieceIcons.rookW
  );
  newBoard[7][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: PieceIcons.rookW
  );

  // Place knights
  newBoard[0][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: PieceIcons.knightB
  );
  newBoard[0][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: PieceIcons.knightB
  );
  newBoard[7][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: PieceIcons.knightW
  );
  newBoard[7][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: PieceIcons.knightW
  );

  // Place bishops
  newBoard[0][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: PieceIcons.bishopB
  );
  newBoard[0][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: PieceIcons.bishopB
  );
  newBoard[7][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: PieceIcons.bishopW
  );
  newBoard[7][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: PieceIcons.bishopW
  );

  // Place queens
  newBoard[0][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: false,
      imagePath: PieceIcons.queenB
  );
  newBoard[7][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: true,
      imagePath: PieceIcons.queenW
  );

  // Place kings
  newBoard[0][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: false,
      imagePath: PieceIcons.kingB
  );
  newBoard[7][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: true,
      imagePath: PieceIcons.kingW
  );

  return newBoard;
}
