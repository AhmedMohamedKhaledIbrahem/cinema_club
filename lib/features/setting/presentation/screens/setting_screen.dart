import 'package:cinema_club/core/shared/theme_shared_preferences.dart';
import 'package:cinema_club/features/add_movie_favorite/presentation/bloc/movie_favorite_bloc.dart';
import 'package:cinema_club/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:cinema_club/features/profileuser/presentation/bloc/profile_user_bloc.dart';
import 'package:cinema_club/features/setting/domain/entities/setting_entity.dart';
import 'package:cinema_club/features/setting/presentation/bloc/setting_bloc.dart';
import 'package:cinema_club/generated/l10n.dart';
import 'package:cinema_club/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:image_picker/image_picker.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingLoaded? stateLoaded;
  @override
  Widget build(BuildContext context) {
    final themePrefs = ThemeSharedPreferences();
    themePrefs.init();
    return BlocProvider<ProfileUserBloc>(
      create: (context) => sl<ProfileUserBloc>()..add(GetProfileUserEvent()),
      child: Scaffold(
          // backgroundColor: Colors.grey,
          body: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationLogout) {
                  Navigator.pushReplacementNamed(context, '/');
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<ProfileUserBloc, ProfileUserState>(
                      builder: (context, state) {
                        if (state is ProfileUserLoading) {
                          return Skeletonizer(
                              child: profileUserSkeleton(context));
                        } else if (state is ProfileUserLoaded) {
                          return profileUser(context, state);
                        } else if (state is UploadedProfileUserPhoto) {
                          context
                              .read<ProfileUserBloc>()
                              .add(GetProfileUserEvent());
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(child: buttons(context)),
                  ],
                ),
              ))),
    );
  }

  profileUser(BuildContext context, ProfileUserLoaded state) {
    final userPhotoUrl = state.profileUserEntitiy.photo;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.13,
      child: Card(
        elevation: 6.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  /**/ final filePath = await pickImageFromGallery();
                  if (filePath != null && mounted) {
                    context
                        .read<ProfileUserBloc>()
                        .add(UploadProfileUserPhotoEvent(pathPhoto: filePath));
                  }
                },
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: userPhotoUrl.isNotEmpty
                      ? NetworkImage(userPhotoUrl)
                      : const AssetImage('assets/image/profileDefult.png')
                          as ImageProvider,
                  backgroundColor: Colors.grey,
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    state.profileUserEntitiy.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    state.profileUserEntitiy.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buttons(
    BuildContext context,
  ) {
    final state = context.read<SettingBloc>().state;
    if (state is SettingLoaded) {
      final currentSettingEntity = state.settingEntity;
      final languageCode = currentSettingEntity.languageCode.isNotEmpty
          ? currentSettingEntity.languageCode
          : PlatformDispatcher.instance.locale.languageCode;
      return Column(
        children: [
          customIconButton(
            assetPath: 'assets/image/nightmode.png',
            buttonText: S.of(context).darkModeLabel,
            onPressed: () {
              context.read<SettingBloc>().add(
                    SaveSettingEvent(
                      settingEntity: SettingEntity(
                        isDarkMode: true,
                        languageCode: languageCode,
                      ),
                    ),
                  );
            },
            context: context,
          ),
          const SizedBox(height: 15),
          customIconButton(
            assetPath: 'assets/image/light-mode.png',
            buttonText: S.of(context).lightModeLabel,
            onPressed: () {
              context.read<SettingBloc>().add(
                    SaveSettingEvent(
                      settingEntity: SettingEntity(
                        isDarkMode: false,
                        languageCode: languageCode,
                      ),
                    ),
                  );
            },
            context: context,
          ),
          const SizedBox(height: 15),
          customIconButton(
            assetPath: 'assets/image/languageselect.png',
            buttonText: S.of(context).languageLabel,
            onPressed: () {
              _showLanguageDialog(context, currentSettingEntity);
            },
            context: context,
          ),
          const SizedBox(height: 15),
          customIconButton(
            assetPath: 'assets/image/logout.png',
            buttonText: S.of(context).logoutLabel,
            onPressed: () {
              context.read<AuthenticationBloc>().add(LogoutEvent());
              context
                  .read<MovieFavoriteBloc>()
                  .add(DeleteAllFavoriteMoviesEvent());
            },
            context: context,
          ),
        ],
      );
    }
  }

  Widget customIconButton({
    required String assetPath,
    required String buttonText,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Button background color
          borderRadius: BorderRadius.circular(20), // Adjust for rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 1, // Blur radius
              offset: const Offset(0, 4), // Shadow offset
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align to the start
            children: [
              Image.asset(
                assetPath, // Use the passed asset path
                height: 24, // Adjust height as needed
                width: 24, // Adjust width as needed
              ),
              const SizedBox(width: 8), // Space between icon and text
              Text(
                buttonText,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 16),
              ), // Use the passed button text
            ],
          ),
        ),
      ),
    );
  }

  Widget profileUserSkeleton(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.13,
        child: Card(
          elevation: 6.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[300],
                ),
                Expanded(
                  child: ListTile(
                    title: Container(
                      width: double.infinity,
                      height: 20,
                      color: Colors.grey[300],
                    ),
                    subtitle: Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    SettingEntity currentSettingEntity,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).languageLabel),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildLanguageTile(
                context,
                S.of(context).englishLanguageLabel,
                'en',
                currentSettingEntity,
              ),
              buildLanguageTile(
                context,
                S.of(context).arabicLanguageLabel,
                'ar',
                currentSettingEntity,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildLanguageTile(
    BuildContext context,
    String languageLabel,
    String languageCode,
    SettingEntity currentSettingEntity,
  ) {
    return ListTile(
      title: Text(languageLabel),
      onTap: () {
        BlocProvider.of<SettingBloc>(context).add(
          SaveSettingEvent(
            settingEntity: SettingEntity(
              isDarkMode: currentSettingEntity.isDarkMode,
              languageCode: languageCode,
            ),
          ),
        );
        Navigator.of(context).pop();
      },
    );
  }

  Future<String?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }
}
