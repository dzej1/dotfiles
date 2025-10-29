1.add keyboard shortcut to run this hyper+esc
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'

2.show quit in finder
defaults write com.apple.finder "QuitMenuItem" -bool "true"

3.keyrepeat instead of longpress
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"

4.do not show language indicator
defaults write kCFPreferencesAnyApplication TSMLanguageIndicatorEnabled -bool "false"

5.zsh is now without history FIXME

6.generate new ssh token

7.<https://ss64.com/mac/syntax-defaults.html>

8. browser keyboard shortcuts

- space switch hyper + 1/2/3
- show hide tab bar

9. {
   NSNavPanelExpandedSizeForOpenMode = "{800, 448}";
   NSOSPLastRootDirectory = {length = 700, bytes = 0x626f6f6b bc020000 00000410 30000000 ... 5c010000 00000000 };
   "NSSplitView Subview Frames raycast_aiChat" = (
   "0.000000, 0.000000, 256.000000, 1000.000000, NO, NO",
   "257.000000, 0.000000, 390.000000, 1000.000000, NO, NO"
   );
   "NSStatusItem Visible Item-1" = 0;
   "NSStatusItem Visible raycastIcon" = 0;
   "NSWindow Frame NSNavPanelAutosaveName" = "560 312 800 448 0 0 1920 1080 ";
   "NSWindow Frame NSSpellCheckerSubstitutionsPanel2" = "692 407 425 137 0 0 1920 1080 ";
   "NSWindow Frame ai-chat-window" = "1104 0 647 1000 0 0 1920 1080 ";
   "NSWindow Frame raycast-focus-session-panel" = "775 20 259 42 0 0 1800 1131 ";
   "NSWindow Frame raycast-notes-window" = "1163 454 418 573 0 0 1920 1080 ";
   aiChatHotkeyDismissed = 1;
   aiDynamicPlaceholdersMigrationDate = "2023-06-08 07:03:40 +0000";
   alwaysAllowCommandDeeplinking = {
   "builtin_command_windowManagementBottomHalf" = 1;
   "builtin_command_windowManagementFirstThreeFourth" = 1;
   "builtin_command_windowManagementMaximize" = 1;
   "builtin_command_windowManagementRightHalf" = 1;
   };
   "amplitudePulseAnalyticsTracker_nextHeartbeatDate" = "2025-10-29 23:00:00 +0000";
   "calculator_currenciesRefresh" = {length = 37, bytes = 0x7b227375 63636565 64656422 3a7b225f ... 34383534 39387d7d };
   "command-extension_brew.search**9349c6b9-c442-4895-98e3-b3a926e74ed7-searchBarAccessory_default_dropdown_id_previousValue" = all;
   "command-extension_kill-process.index**c0c9423a-7014-481e-8bb9-44c4c6df53be-searchBarAccessory_default_dropdown_id_previousValue" = cpu;
   "command-extension_visual-studio-code.index**95e41a2e-a943-4d49-b0df-152c3db2f7e0-searchBarAccessory_default_dropdown_id_previousValue" = "All Types";
   "commandScheduler_commandRuns" = {
   };
   commandsPreferencesExpandedItemIds = (
   "builtin_package_scriptCommands",
   quicklinks,
   "builtin_package_open-ai",
   "builtin_package_windowManagement",
   "extension_toothpick**1d7e24ea-6166-41b0-a549-fe87467c0900",
   applications,
   "builtin_package_systemCommands"
   );
   commandsPreferencesLastSelectedFilterTab = all;
   commandsPreferencesShowOnlyCustomized = 1;
   commandsPreferencesShowOnlyEnabled = 0;
   "create-script-command-author" = "";
   "create-script-command-authorURL" = "";
   currenciesRefreshDate = "1739168498.94133";
   "database_lastValidAppVersion" = "1.103.5";
   "database_lastValidOSVersion" = "15.6.0";
   didMigrationForClipboardHistoryFavicons = 1;
   "emojiPicker_skinTone" = standard;
   "fallbackSearches_didMigrateScriptCommands" = 1;
   faviconProvider = legacy;
   "floatingNotes_didCreateOnboardingNote" = 1;
   "floatingNotes_didMigrateFloatingNotesHotkeysAndAliases" = 1;
   "floatingNotes_didMigrateFloatingNotesRecords" = 1;
   "floatingNotes_lastSelectedDocumentId" = "9FD2A3F0-5E07-4D64-A4FB-1C23A852C22B";
   "floatingNotes_raycastNotesFormatBarVisible" = 1;
   "floatingNotes_raycastNotesNavigateBackStack" = (
   "582C3F7A-1767-48B1-AD18-7180339D313F",
   "B947280E-9746-472F-94E6-3D968080282B",
   "B947280E-9746-472F-94E6-3D968080282B",
   "9A65AD23-98AA-4EB6-9442-F9A0135B480E",
   "B947280E-9746-472F-94E6-3D968080282B",
   "5686FE2E-5E02-4052-A0A3-C8F1416D2502",
   "BC8620C7-F46B-46F0-9155-49C337AC2912",
   "5686FE2E-5E02-4052-A0A3-C8F1416D2502",
   "4AED45F3-F625-41ED-B5EC-3BC898471CCC",
   "5BB2322F-F3C4-440E-BA35-6670BF6B475D",
   "5BB2322F-F3C4-440E-BA35-6670BF6B475D",
   "4AED45F3-F625-41ED-B5EC-3BC898471CCC",
   "5BB2322F-F3C4-440E-BA35-6670BF6B475D",
   "5686FE2E-5E02-4052-A0A3-C8F1416D2502",
   "5BB2322F-F3C4-440E-BA35-6670BF6B475D",
   "5686FE2E-5E02-4052-A0A3-C8F1416D2502",
   "4AED45F3-F625-41ED-B5EC-3BC898471CCC",
   "A8F5BD87-1365-4593-B5B6-2E6878777009",
   "5686FE2E-5E02-4052-A0A3-C8F1416D2502",
   "A8F5BD87-1365-4593-B5B6-2E6878777009",
   "4AED45F3-F625-41ED-B5EC-3BC898471CCC",
   "A8F5BD87-1365-4593-B5B6-2E6878777009",
   "2A6E5A09-8D89-49C5-8A80-0BFCF99117AD",
   "B947280E-9746-472F-94E6-3D968080282B",
   "5686FE2E-5E02-4052-A0A3-C8F1416D2502",
   "A8F5BD87-1365-4593-B5B6-2E6878777009",
   "EE116A85-35ED-47E8-AD41-EA0A71DB383F",
   "B947280E-9746-472F-94E6-3D968080282B",
   "5686FE2E-5E02-4052-A0A3-C8F1416D2502",
   "9A65AD23-98AA-4EB6-9442-F9A0135B480E",
   "B947280E-9746-472F-94E6-3D968080282B",
   "9A65AD23-98AA-4EB6-9442-F9A0135B480E",
   "EE116A85-35ED-47E8-AD41-EA0A71DB383F",
   "9A65AD23-98AA-4EB6-9442-F9A0135B480E",
   "B947280E-9746-472F-94E6-3D968080282B",
   "9A65AD23-98AA-4EB6-9442-F9A0135B480E",
   "EE116A85-35ED-47E8-AD41-EA0A71DB383F",
   "EBE7876D-F0D3-4241-A9DD-286BD23733B7",
   "EE116A85-35ED-47E8-AD41-EA0A71DB383F",
   "A8F5BD87-1365-4593-B5B6-2E6878777009",
   "9FD2A3F0-5E07-4D64-A4FB-1C23A852C22B",
   "A8F5BD87-1365-4593-B5B6-2E6878777009",
   "9A65AD23-98AA-4EB6-9442-F9A0135B480E",
   "A8F5BD87-1365-4593-B5B6-2E6878777009",
   "9FD2A3F0-5E07-4D64-A4FB-1C23A852C22B",
   "A8F5BD87-1365-4593-B5B6-2E6878777009",
   "EE116A85-35ED-47E8-AD41-EA0A71DB383F",
   "9FD2A3F0-5E07-4D64-A4FB-1C23A852C22B",
   "A8F5BD87-1365-4593-B5B6-2E6878777009"
   );
   "floatingNotes_raycastNotesNavigateForwardStack" = (
   );
   "floatingNotes_raycastNotesWindowAutoresizingEnabled" = 0;
   initialSpotlightHotkey = "Command-49";
   "ios_showAnnouncement" = 0;
   mainWindowPositionCache = {
   "1(0.0, 0.0, 1512.0, 982.0)" = "{381, 743}";
   "1(0.0, 0.0, 1800.0, 1169.0)" = "{525, 879}";
   "1(1920.0, 0.0, 1512.0, 982.0)" = "{2301, 743}";
   "1(1920.0, 149.0, 1512.0, 982.0)" = "{2301, 892}";
   "2(0.0, 0.0, 1920.0, 1080.0)" = "{585, 916}";
   "3(0.0, 0.0, 1920.0, 1080.0)" = "{585, 817}";
   };
   "mainWindow_isMonitoringGlobalHotkeys" = 1;
   onboardingCompleted = 1;
   "onboarding_completedTaskIdentifiers" = (
   quicklinks,
   installFirstExtension,
   floatingNotes,
   setHotkeyAndAlias,
   calendar,
   snippets,
   raycastShortcuts,
   openActionPanel,
   startWalkthrough,
   calculator,
   windowManagement
   );
   "onboarding_raycastShortcuts" = (
   "\\U2318Esc",
   "\\U2318,",
   Esc,
   "\\U2318W"
   );
   "onboarding_setupAlias" = 1;
   "onboarding_setupHotkey" = 1;
   "onboarding_showTasksProgress" = 1;
   organizationsPreferencesTabVisited = 1;
   "raycast-preferences-restorableData" = {length = 78, bytes = 0x7b227479 70654e61 6d65223a 22457874 ... 2e393931 3938337d };
   "raycast-startFocusSession-blockable-items" = {length = 108018, bytes = 0x5b7b2274 69746c65 223a2266 61636562 ... 3d227d7d 7d7d7d5d };
   "raycast-startFocusSession-duration" = {length = 81, bytes = 0x7b226964 223a2237 43454531 3130442d ... 696e7574 6573227d };
   "raycast-startFocusSession-title" = yeah;
   "raycast-updates-lastAppUpdateCheckDate" = "1761753132.309383";
   "raycast-updates-lastTargetCommitishInstalled" = f76bff59172a3f656c1ea7bce2736f631c05dcd1;
   "raycast-updates-versionOfLastSeenReleaseNotes" = "1.103.0";
   "raycast-updates-whatsNewItemDisplayDate" = "1761724299.8975";
   "raycastAI_lastSelectedChatId" = "52AFE587-F406-4E1F-88CA-B07E10E91870";
   "raycastAI_ollamaModelsList" = {length = 2, bytes = 0x5b5d};
   "raycastAccountService_cloudSyncWalkthroughShown" = 1;
   "raycastAccountService_proPlanWalkthroughShownOnCurrentDevice" = 1;
   raycastAiHasSeenQuickAI = 1;
   raycastAnonymousId = "AB508B69-8E39-4E6B-A30C-4D704F26A2EA";
   raycastCurrentThemeId = "bundled-raycast-dark";
   raycastCurrentThemeIdDarkAppearance = "bundled-raycast-dark";
   raycastFirstKnownAppVersion = {length = 8, bytes = 0x22312e34392e3322};
   raycastGlobalHotkey = "Command-49";
   raycastInstallationDate = "2023-04-21 07:41:03 +0000";
   raycastLoginItemAutoInstalled = "2023-04-21 07:41:04 +0000";
   raycastPreferredWindowMode = compact;
   raycastShouldFollowSystemAppearance = 0;
   "raycastUI_preferredTextSize" = medium;
   "raycast_hyperKey_state" = {
   enabled = 0;
   includeShiftKey = 1;
   keyCode = 57;
   };
   "reminders-createReminder-list" = "722C9942-69BC-4C57-BE23-362A6F555D15";
   "reminders-createReminder-priority" = 1;
   "script-command-mode" = Silent;
   "script-command-template" = Bash;
   showGettingStartedLink = 0;
   "siriShortcuts_siriShortcutsPermissionState" = rejected;
   "store_everInstalled" = (
   "2c5e16da-6d7e-4b83-8949-aba0efc9bb75",
   "d5d27df2-9818-41ea-b683-0e4af3f4be3d",
   "378b5b10-3a1a-49df-9e99-70fa2a9704c4",
   "1d7e24ea-6166-41b0-a549-fe87467c0900",
   "95e41a2e-a943-4d49-b0df-152c3db2f7e0",
   "bd66a1ad-75d7-4b26-8ea7-92fcc9adf473",
   "4f82f18c-51bc-4b7d-a1fa-342a5d5e2fc8",
   "1a1d5973-4f75-45bf-9eb3-f8df3613952d",
   "320f40ef-a633-415a-ab0e-1e99515478f7",
   "89648e03-cceb-4205-9f40-75fcb039a4c6",
   "4d4af936-2e32-446b-a8f9-d710b41aa36d",
   "0d8759fb-4764-4b49-8e51-5245ecc5ffb4",
   "c0c9423a-7014-481e-8bb9-44c4c6df53be",
   "a9696c4c-a4e8-4ff1-bf49-c9015f796200",
   "0ceb0ec5-feb7-41fe-876c-c6c9c72940dc",
   "3844c7a5-9903-488e-b00d-f30865c41083",
   "9349c6b9-c442-4895-98e3-b3a926e74ed7"
   );
   "store_migratedHackerNews" = 1;
   "store_migratedNative" = 1;
   "store_migratedReminders" = 1;
   "store_termsAccepted" = 1;
   "subscriptions_active" = 0;
   "subscriptions_needsProTrialEnrolment" = 0;
   useHyperKeyIcon = 0;
   }

10. spotify - size 80%, artwork instead of canvas

11. no delay between lockscreen and sleep
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

12. control + \ - screenshot with picker

13. disable airplay reciever
