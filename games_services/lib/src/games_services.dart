import 'dart:async';
export 'package:games_services_platform_interface/models.dart';
import '../games_services.dart';

/// A helper class that has all the library functions in one class.
/// This class to support apps that uses pre 3.0 versions.
/// Please consider using [GameAuth] for authintication, [Achievements] for anything related to Achievements,
/// [Leaderboards] for anything related to Leaderboards, [Player] for anything related to Player,
/// [SaveGame] for anything related to save game.
class GamesServices {
  /// To sign in the user.
  /// If you pass [shouldEnableSavedGame], a drive scope will be will be added to GoogleSignInOptions. This will happed just
  /// android as for iOS/macOS nothing is required to be sent when authenticate.
  /// You need to call the sign in before making any action,
  /// (like sending a score or unlocking an achievement).
  static Future<String?> signIn({bool shouldEnableSavedGame = false}) async {
    return await GameAuth.signIn(shouldEnableSavedGame: shouldEnableSavedGame);
  }

  /// Check to see if the user is currently signed into
  /// Game Center or Google Play Services
  static Future<bool> get isSignedIn async => await GameAuth.isSignedIn;

  /// To sign the user out of Goole Play Services.
  /// After calling, you can no longer make any actions
  /// on the user's account.
  static Future<String?> signOut() async {
    return await GameAuth.signOut();
  }

  /// It will open the achievements screen.
  static Future<String?> showAchievements() async {
    return await Achievements.showAchievements();
  }

  /// Get achievements as a list. Use this to build your own custom UI.
  /// To show the prebuilt system UI use [showAchievements]
  static Future<List<AchievementItemData>?> loadAchievements() async {
    return await Achievements.loadAchievements();
  }

  /// Unlock an [achievement].
  /// [Achievement] takes three parameters:
  /// [androidID] the achievement id for android.
  /// [iOSID] the achievement id for iOS.
  /// [percentComplete] the completion percent of the achievement, this parameter is
  /// optional in case of iOS.
  static Future<String?> unlock({required Achievement achievement}) async {
    return await Achievements.unlock(achievement: achievement);
  }

  /// Increment an [achievement].
  /// [Achievement] takes two parameters:
  /// [androidID] the achievement id for android.
  /// [steps] If the achievement is of the incremental type
  /// you can use this method to increment the steps.
  /// * only for Android (see https://developers.google.com/games/services/android/achievements#unlocking_achievements).
  static Future<String?> increment({required Achievement achievement}) async {
    return await Achievements.increment(achievement: achievement);
  }

  /// It will open the leaderboards screen.
  static Future<String?> showLeaderboards(
      {iOSLeaderboardID = "", androidLeaderboardID = ""}) async {
    return await Leaderboards.showLeaderboards(
        iOSLeaderboardID: iOSLeaderboardID,
        androidLeaderboardID: androidLeaderboardID);
  }

  /// Submit a [score] to specific leader board.
  /// [Score] takes three parameters:
  /// [androidLeaderboardID] the leader board id that you want to send the score for in case of android.
  /// [iOSLeaderboardID] the leader board id that you want to send the score for in case of iOS.
  /// [value] the score.
  static Future<String?> submitScore({required Score score}) async {
    return await Leaderboards.submitScore(score: score);
  }

  /// Get the player id.
  /// On iOS the player id is unique for your game but not other games.
  static Future<String?> getPlayerID() async {
    return await Player.getPlayerID();
  }

  /// Get player score for a specific leaderboard.
  static Future<int?> getPlayerScore(
      {iOSLeaderboardID = "", androidLeaderboardID = ""}) async {
    return await Player.getPlayerScore(
        iOSLeaderboardID: iOSLeaderboardID,
        androidLeaderboardID: androidLeaderboardID);
  }

  /// Get the player name.
  /// On iOS the player alias is the name used by the Player visible in the leaderboard
  static Future<String?> getPlayerName() async {
    return await Player.getPlayerName();
  }

  /// Show the iOS Access Point.
  static Future<String?> showAccessPoint(AccessPointLocation location) async {
    return await Player.showAccessPoint(location);
  }

  /// Hide the iOS Access Point.
  static Future<String?> hideAccessPoint() async {
    return await Player.hideAccessPoint();
  }

  /// Save game with [data] and a unique [name].
  /// The [name] must be between 1 and 100 non-URL-reserved characters (a-z, A-Z, 0-9, or the symbols "-", ".", "_", or "~").
  static Future<String?> saveGame(
      {required String data, required String name}) async {
    return await SaveGame.saveGame(data: data, name: name);
  }

  /// Load game with [name].
  static Future<String?> loadGame({required String name}) async {
    return await SaveGame.loadGame(name: name);
  }

  /// Get all saved games.
  static Future<List<SavedGame>?> getSavedGames() async {
    return await SaveGame.getSavedGames();
  }

  /// Delete game with [name].
  static Future<String?> deleteGame({required String name}) async {
    return await SaveGame.deleteGame(name: name);
  }
}
