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

  static const boardBlack = '$_boardDesign/boardB.png';
  static const boardWhite = '$_boardDesign/boardW.png';




  static const logo = '$_global/logo.svg';
}
abstract class PieceIcons {
  static const pawnB = '$_pieceDesign/blackPawn.png';
  static const knightB = '$_pieceDesign/blackKnight.png';
  static const bishopB = '$_pieceDesign/blackBishop.png';
  static const rookB = '$_pieceDesign/blackRook.png';
  static const queenB = '$_pieceDesign/blackQueen.png';
  static const kingB = '$_pieceDesign/blackKing.png';

  static const pawnW = '$_pieceDesign/whitePawn.png';
  static const knightW = '$_pieceDesign/whiteKnight.png';
  static const bishopW = '$_pieceDesign/whiteBishop.png';
  static const rookW = '$_pieceDesign/whiteRook.png';
  static const queenW = '$_pieceDesign/whiteQueen.png';
  static const kingW = '$_pieceDesign/whiteKing.png';


}