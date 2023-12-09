const _onboardingIcons = 'assets/icons/onboarding';
const _onboardingImages = 'assets/images/onboarding';
const _global = 'assets/icons/global';
const _mainMenu = 'assets/images/mainMenu';
const _boardDesign = 'assets/images/boardDesign';
const _pieceDesign = 'assets/images/piece';

abstract class AppIcons {
  static const mainLogo = 'assets/logo.png';

  static const time = '$_onboardingImages/time.png';
  static const friends = '$_onboardingImages/friends.png';
  static const kings = '$_onboardingImages/kings.png';
  static const world_player = '$_onboardingImages/world_player.png';


  static const next = '$_onboardingIcons/next.svg';
  static const back = '$_onboardingIcons/back.svg';

  static const comingSoon = 'assets/images/coming.png';
  static const mainMenu = '$_mainMenu/mainMenu.png';
  static const mainMenu2 = '$_mainMenu/mainMenu2.png';
  static const mainMenu3 = '$_mainMenu/mainMenu3.png';
  static const mainWidget = '$_mainMenu/mainWidget.png';
  static const mainButton = '$_mainMenu/mainButton.png';

  static const mainBoard = '$_boardDesign/mainBoard.png';
  static const nullBoard = '$_boardDesign/nullBoard.png';
  static const boardSelected = '$_boardDesign/boardSelected.png';
  static const boardSelectedDirect = '$_boardDesign/boardSelectedDirect.png';


  static const logo = '$_global/logo.svg';
}

abstract class BlackPiecePath {
  static const pawn = '$_pieceDesign/blackPawn.png';
  static const knight = '$_pieceDesign/blackKnight.png';
  static const bishop = '$_pieceDesign/blackBishop.png';
  static const rook = '$_pieceDesign/blackRook.png';
  static const queen = '$_pieceDesign/blackQueen.png';
  static const king = '$_pieceDesign/blackKing.png';
}
abstract class WhitePiecePath {
  static const pawn = '$_pieceDesign/whitePawn.png';
  static const knight = '$_pieceDesign/whiteKnight.png';
  static const bishop = '$_pieceDesign/whiteBishop.png';
  static const rook = '$_pieceDesign/whiteRook.png';
  static const queen = '$_pieceDesign/whiteQueen.png';
  static const king = '$_pieceDesign/whiteKing.png';
}