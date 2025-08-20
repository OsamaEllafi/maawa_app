import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Maawa'**
  String get appTitle;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @properties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get properties;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @styleGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'Style Guide'**
  String get styleGuideTitle;

  /// No description provided for @typography.
  ///
  /// In en, this message translates to:
  /// **'Typography'**
  String get typography;

  /// No description provided for @colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors;

  /// No description provided for @buttons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get buttons;

  /// No description provided for @inputs.
  ///
  /// In en, this message translates to:
  /// **'Inputs'**
  String get inputs;

  /// No description provided for @cards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get cards;

  /// No description provided for @spacing.
  ///
  /// In en, this message translates to:
  /// **'Spacing'**
  String get spacing;

  /// No description provided for @animations.
  ///
  /// In en, this message translates to:
  /// **'Animations'**
  String get animations;

  /// No description provided for @themeToggle.
  ///
  /// In en, this message translates to:
  /// **'Toggle Theme'**
  String get themeToggle;

  /// No description provided for @languageToggle.
  ///
  /// In en, this message translates to:
  /// **'Toggle Language'**
  String get languageToggle;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @devTools.
  ///
  /// In en, this message translates to:
  /// **'Developer Tools'**
  String get devTools;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @devToolsTitle.
  ///
  /// In en, this message translates to:
  /// **'Developer Tools'**
  String get devToolsTitle;

  /// No description provided for @styleGuide.
  ///
  /// In en, this message translates to:
  /// **'Style Guide'**
  String get styleGuide;

  /// No description provided for @roleSimulator.
  ///
  /// In en, this message translates to:
  /// **'Role Simulator'**
  String get roleSimulator;

  /// No description provided for @currentRole.
  ///
  /// In en, this message translates to:
  /// **'Current Role'**
  String get currentRole;

  /// No description provided for @tenant.
  ///
  /// In en, this message translates to:
  /// **'Tenant'**
  String get tenant;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get notFound;

  /// No description provided for @notFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get notFoundTitle;

  /// No description provided for @notFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'404 - Page Not Found'**
  String get notFoundMessage;

  /// No description provided for @notFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The page you\'re looking for doesn\'t exist or has been moved.'**
  String get notFoundSubtitle;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get goHome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordsDontMatch;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequired;

  /// No description provided for @nameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get nameTooShort;

  /// No description provided for @idNumber.
  ///
  /// In en, this message translates to:
  /// **'ID Number'**
  String get idNumber;

  /// No description provided for @idNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'ID number is required'**
  String get idNumberRequired;

  /// No description provided for @idNumberTooShort.
  ///
  /// In en, this message translates to:
  /// **'ID number must be at least 5 characters'**
  String get idNumberTooShort;

  /// No description provided for @iban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get iban;

  /// No description provided for @ibanRequired.
  ///
  /// In en, this message translates to:
  /// **'IBAN is required'**
  String get ibanRequired;

  /// No description provided for @ibanTooShort.
  ///
  /// In en, this message translates to:
  /// **'IBAN must be at least 10 characters'**
  String get ibanTooShort;

  /// No description provided for @invalidIban.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid IBAN format'**
  String get invalidIban;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberRequired;

  /// No description provided for @identityVerification.
  ///
  /// In en, this message translates to:
  /// **'Identity Verification'**
  String get identityVerification;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @submitVerification.
  ///
  /// In en, this message translates to:
  /// **'Submit Verification'**
  String get submitVerification;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check Your Email'**
  String get checkYourEmail;

  /// No description provided for @emailSentMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a password reset link to'**
  String get emailSentMessage;

  /// No description provided for @tryDifferentEmail.
  ///
  /// In en, this message translates to:
  /// **'Try Different Email'**
  String get tryDifferentEmail;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Please sign in to continue.'**
  String get welcomeBack;

  /// No description provided for @createAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Create your account to get started.'**
  String get createAccountMessage;

  /// No description provided for @forgotPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get forgotPasswordMessage;

  /// No description provided for @kycMessage.
  ///
  /// In en, this message translates to:
  /// **'Please provide accurate information for identity verification.'**
  String get kycMessage;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @invalidIdTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid ID'**
  String get invalidIdTitle;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @invalidPropertyIdMessage.
  ///
  /// In en, this message translates to:
  /// **'Property with ID \'{id}\' was not found. It may have been removed or the ID is incorrect.'**
  String invalidPropertyIdMessage(Object id);

  /// No description provided for @invalidBookingIdMessage.
  ///
  /// In en, this message translates to:
  /// **'Booking with ID \'{id}\' was not found. It may have been cancelled or the ID is incorrect.'**
  String invalidBookingIdMessage(Object id);

  /// No description provided for @paymentSimulated.
  ///
  /// In en, this message translates to:
  /// **'Payment simulated'**
  String get paymentSimulated;

  /// No description provided for @invalidIdMessage.
  ///
  /// In en, this message translates to:
  /// **'Item with ID \'{id}\' was not found. It may have been removed or the ID is incorrect.'**
  String invalidIdMessage(Object id);

  /// No description provided for @ownerPropertiesTitle.
  ///
  /// In en, this message translates to:
  /// **'My Properties'**
  String get ownerPropertiesTitle;

  /// No description provided for @addProperty.
  ///
  /// In en, this message translates to:
  /// **'Add Property'**
  String get addProperty;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @published.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get published;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @perNight.
  ///
  /// In en, this message translates to:
  /// **'per night'**
  String get perNight;

  /// No description provided for @guests.
  ///
  /// In en, this message translates to:
  /// **'Guests'**
  String get guests;

  /// No description provided for @media.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get media;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @submitForApproval.
  ///
  /// In en, this message translates to:
  /// **'Submit for Approval'**
  String get submitForApproval;

  /// No description provided for @submitForApprovalMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to submit this property for approval? This action cannot be undone.'**
  String get submitForApprovalMessage;

  /// No description provided for @propertySubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Property submitted successfully!'**
  String get propertySubmittedSuccessfully;

  /// No description provided for @noDraftProperties.
  ///
  /// In en, this message translates to:
  /// **'No draft properties'**
  String get noDraftProperties;

  /// No description provided for @noPendingProperties.
  ///
  /// In en, this message translates to:
  /// **'No pending properties'**
  String get noPendingProperties;

  /// No description provided for @noPublishedProperties.
  ///
  /// In en, this message translates to:
  /// **'No published properties'**
  String get noPublishedProperties;

  /// No description provided for @noRejectedProperties.
  ///
  /// In en, this message translates to:
  /// **'No rejected properties'**
  String get noRejectedProperties;

  /// No description provided for @addFirstProperty.
  ///
  /// In en, this message translates to:
  /// **'Add First Property'**
  String get addFirstProperty;

  /// No description provided for @editProperty.
  ///
  /// In en, this message translates to:
  /// **'Edit Property'**
  String get editProperty;

  /// No description provided for @basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInformation;

  /// No description provided for @propertyTitle.
  ///
  /// In en, this message translates to:
  /// **'Property Title'**
  String get propertyTitle;

  /// No description provided for @propertyTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a descriptive title for your property'**
  String get propertyTitleHint;

  /// No description provided for @propertyTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Property title is required'**
  String get propertyTitleRequired;

  /// No description provided for @propertyTitleTooShort.
  ///
  /// In en, this message translates to:
  /// **'Title must be at least 10 characters'**
  String get propertyTitleTooShort;

  /// No description provided for @propertyDescription.
  ///
  /// In en, this message translates to:
  /// **'Property Description'**
  String get propertyDescription;

  /// No description provided for @propertyDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe your property in detail'**
  String get propertyDescriptionHint;

  /// No description provided for @propertyDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Property description is required'**
  String get propertyDescriptionRequired;

  /// No description provided for @propertyDescriptionTooShort.
  ///
  /// In en, this message translates to:
  /// **'Description must be at least 50 characters'**
  String get propertyDescriptionTooShort;

  /// No description provided for @propertyDetails.
  ///
  /// In en, this message translates to:
  /// **'Property Details'**
  String get propertyDetails;

  /// No description provided for @propertyType.
  ///
  /// In en, this message translates to:
  /// **'Property Type'**
  String get propertyType;

  /// No description provided for @apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get apartment;

  /// No description provided for @house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get house;

  /// No description provided for @villa.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get villa;

  /// No description provided for @studio.
  ///
  /// In en, this message translates to:
  /// **'Studio'**
  String get studio;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the full address'**
  String get addressHint;

  /// No description provided for @addressRequired.
  ///
  /// In en, this message translates to:
  /// **'Address is required'**
  String get addressRequired;

  /// No description provided for @pricePerNight.
  ///
  /// In en, this message translates to:
  /// **'Price per Night'**
  String get pricePerNight;

  /// No description provided for @priceHint.
  ///
  /// In en, this message translates to:
  /// **'Enter price in LYD'**
  String get priceHint;

  /// No description provided for @priceRequired.
  ///
  /// In en, this message translates to:
  /// **'Price is required'**
  String get priceRequired;

  /// No description provided for @priceInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid price'**
  String get priceInvalid;

  /// No description provided for @capacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get capacity;

  /// No description provided for @capacityHint.
  ///
  /// In en, this message translates to:
  /// **'Number of guests'**
  String get capacityHint;

  /// No description provided for @capacityRequired.
  ///
  /// In en, this message translates to:
  /// **'Capacity is required'**
  String get capacityRequired;

  /// No description provided for @capacityInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid capacity'**
  String get capacityInvalid;

  /// No description provided for @checkInTime.
  ///
  /// In en, this message translates to:
  /// **'Check-in Time'**
  String get checkInTime;

  /// No description provided for @checkInTimeRequired.
  ///
  /// In en, this message translates to:
  /// **'Check-in time is required'**
  String get checkInTimeRequired;

  /// No description provided for @checkOutTime.
  ///
  /// In en, this message translates to:
  /// **'Check-out Time'**
  String get checkOutTime;

  /// No description provided for @checkOutTimeRequired.
  ///
  /// In en, this message translates to:
  /// **'Check-out time is required'**
  String get checkOutTimeRequired;

  /// No description provided for @amenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get amenities;

  /// No description provided for @updateProperty.
  ///
  /// In en, this message translates to:
  /// **'Update Property'**
  String get updateProperty;

  /// No description provided for @createProperty.
  ///
  /// In en, this message translates to:
  /// **'Create Property'**
  String get createProperty;

  /// No description provided for @propertyUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Property updated successfully!'**
  String get propertyUpdatedSuccessfully;

  /// No description provided for @propertyCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Property created successfully!'**
  String get propertyCreatedSuccessfully;

  /// No description provided for @mediaManager.
  ///
  /// In en, this message translates to:
  /// **'Media Manager'**
  String get mediaManager;

  /// No description provided for @addMedia.
  ///
  /// In en, this message translates to:
  /// **'Add Media'**
  String get addMedia;

  /// No description provided for @mediaManagerInstructions.
  ///
  /// In en, this message translates to:
  /// **'Drag to reorder, tap to set primary image, or add new media'**
  String get mediaManagerInstructions;

  /// No description provided for @addMoreMedia.
  ///
  /// In en, this message translates to:
  /// **'Add More'**
  String get addMoreMedia;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @primary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get primary;

  /// No description provided for @primaryImage.
  ///
  /// In en, this message translates to:
  /// **'Primary Image'**
  String get primaryImage;

  /// No description provided for @setAsPrimary.
  ///
  /// In en, this message translates to:
  /// **'Set as Primary'**
  String get setAsPrimary;

  /// No description provided for @deleteMedia.
  ///
  /// In en, this message translates to:
  /// **'Delete Media'**
  String get deleteMedia;

  /// No description provided for @noMediaItems.
  ///
  /// In en, this message translates to:
  /// **'No media items'**
  String get noMediaItems;

  /// No description provided for @addMediaToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Add photos and videos to showcase your property'**
  String get addMediaToGetStarted;

  /// No description provided for @addFirstMedia.
  ///
  /// In en, this message translates to:
  /// **'Add First Media'**
  String get addFirstMedia;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @addVideo.
  ///
  /// In en, this message translates to:
  /// **'Add Video'**
  String get addVideo;

  /// No description provided for @imageAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Image added successfully!'**
  String get imageAddedSuccessfully;

  /// No description provided for @videoAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Video added successfully!'**
  String get videoAddedSuccessfully;

  /// No description provided for @primaryImageSet.
  ///
  /// In en, this message translates to:
  /// **'Primary image set successfully!'**
  String get primaryImageSet;

  /// No description provided for @deleteMediaConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this media item?'**
  String get deleteMediaConfirmation;

  /// No description provided for @mediaDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Media deleted successfully!'**
  String get mediaDeletedSuccessfully;

  /// No description provided for @mediaChangesSaved.
  ///
  /// In en, this message translates to:
  /// **'Media changes saved successfully!'**
  String get mediaChangesSaved;

  /// No description provided for @navBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get navBack;

  /// No description provided for @displayLarge.
  ///
  /// In en, this message translates to:
  /// **'Display Large'**
  String get displayLarge;

  /// No description provided for @displayMedium.
  ///
  /// In en, this message translates to:
  /// **'Display Medium'**
  String get displayMedium;

  /// No description provided for @displaySmall.
  ///
  /// In en, this message translates to:
  /// **'Display Small'**
  String get displaySmall;

  /// No description provided for @headlineLarge.
  ///
  /// In en, this message translates to:
  /// **'Headline Large'**
  String get headlineLarge;

  /// No description provided for @headlineMedium.
  ///
  /// In en, this message translates to:
  /// **'Headline Medium'**
  String get headlineMedium;

  /// No description provided for @headlineSmall.
  ///
  /// In en, this message translates to:
  /// **'Headline Small'**
  String get headlineSmall;

  /// No description provided for @titleLarge.
  ///
  /// In en, this message translates to:
  /// **'Title Large'**
  String get titleLarge;

  /// No description provided for @titleMedium.
  ///
  /// In en, this message translates to:
  /// **'Title Medium'**
  String get titleMedium;

  /// No description provided for @titleSmall.
  ///
  /// In en, this message translates to:
  /// **'Title Small'**
  String get titleSmall;

  /// No description provided for @bodyLarge.
  ///
  /// In en, this message translates to:
  /// **'Body Large - This is body large text with sufficient line height for readability.'**
  String get bodyLarge;

  /// No description provided for @bodyMedium.
  ///
  /// In en, this message translates to:
  /// **'Body Medium - This is body medium text for general content.'**
  String get bodyMedium;

  /// No description provided for @bodySmall.
  ///
  /// In en, this message translates to:
  /// **'Body Small - This is body small text for secondary information.'**
  String get bodySmall;

  /// No description provided for @labelLarge.
  ///
  /// In en, this message translates to:
  /// **'Label Large'**
  String get labelLarge;

  /// No description provided for @labelMedium.
  ///
  /// In en, this message translates to:
  /// **'Label Medium'**
  String get labelMedium;

  /// No description provided for @labelSmall.
  ///
  /// In en, this message translates to:
  /// **'Label Small'**
  String get labelSmall;

  /// No description provided for @secondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get secondary;

  /// No description provided for @surface.
  ///
  /// In en, this message translates to:
  /// **'Surface'**
  String get surface;

  /// No description provided for @background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get background;

  /// No description provided for @primaryButton.
  ///
  /// In en, this message translates to:
  /// **'Primary Button'**
  String get primaryButton;

  /// No description provided for @secondaryButton.
  ///
  /// In en, this message translates to:
  /// **'Secondary Button'**
  String get secondaryButton;

  /// No description provided for @outlinedButton.
  ///
  /// In en, this message translates to:
  /// **'Outlined Button'**
  String get outlinedButton;

  /// No description provided for @textButton.
  ///
  /// In en, this message translates to:
  /// **'Text Button'**
  String get textButton;

  /// No description provided for @iconButton.
  ///
  /// In en, this message translates to:
  /// **'Icon Button'**
  String get iconButton;

  /// No description provided for @disabledButton.
  ///
  /// In en, this message translates to:
  /// **'Disabled Button'**
  String get disabledButton;

  /// No description provided for @textField.
  ///
  /// In en, this message translates to:
  /// **'Text Field'**
  String get textField;

  /// No description provided for @emailField.
  ///
  /// In en, this message translates to:
  /// **'Email Field'**
  String get emailField;

  /// No description provided for @passwordField.
  ///
  /// In en, this message translates to:
  /// **'Password Field'**
  String get passwordField;

  /// No description provided for @searchField.
  ///
  /// In en, this message translates to:
  /// **'Search Field'**
  String get searchField;

  /// No description provided for @multilineField.
  ///
  /// In en, this message translates to:
  /// **'Multiline Field'**
  String get multilineField;

  /// No description provided for @placeholder.
  ///
  /// In en, this message translates to:
  /// **'Enter text here...'**
  String get placeholder;

  /// No description provided for @basicCard.
  ///
  /// In en, this message translates to:
  /// **'Basic Card'**
  String get basicCard;

  /// No description provided for @elevatedCard.
  ///
  /// In en, this message translates to:
  /// **'Elevated Card'**
  String get elevatedCard;

  /// No description provided for @outlinedCard.
  ///
  /// In en, this message translates to:
  /// **'Outlined Card'**
  String get outlinedCard;

  /// No description provided for @cardContent.
  ///
  /// In en, this message translates to:
  /// **'This is card content with some sample text to demonstrate the card layout and typography.'**
  String get cardContent;

  /// No description provided for @xs.
  ///
  /// In en, this message translates to:
  /// **'Extra Small (4px)'**
  String get xs;

  /// No description provided for @sm.
  ///
  /// In en, this message translates to:
  /// **'Small (8px)'**
  String get sm;

  /// No description provided for @md.
  ///
  /// In en, this message translates to:
  /// **'Medium (16px)'**
  String get md;

  /// No description provided for @lg.
  ///
  /// In en, this message translates to:
  /// **'Large (24px)'**
  String get lg;

  /// No description provided for @xl.
  ///
  /// In en, this message translates to:
  /// **'Extra Large (32px)'**
  String get xl;

  /// No description provided for @xxl.
  ///
  /// In en, this message translates to:
  /// **'2X Large (48px)'**
  String get xxl;

  /// No description provided for @fadeIn.
  ///
  /// In en, this message translates to:
  /// **'Fade In'**
  String get fadeIn;

  /// No description provided for @slideIn.
  ///
  /// In en, this message translates to:
  /// **'Slide In'**
  String get slideIn;

  /// No description provided for @scaleIn.
  ///
  /// In en, this message translates to:
  /// **'Scale In'**
  String get scaleIn;

  /// No description provided for @bounce.
  ///
  /// In en, this message translates to:
  /// **'Bounce'**
  String get bounce;

  /// No description provided for @stagger.
  ///
  /// In en, this message translates to:
  /// **'Stagger'**
  String get stagger;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @bookingRequest.
  ///
  /// In en, this message translates to:
  /// **'Booking Request'**
  String get bookingRequest;

  /// No description provided for @checkInDate.
  ///
  /// In en, this message translates to:
  /// **'Check-in Date'**
  String get checkInDate;

  /// No description provided for @checkOutDate.
  ///
  /// In en, this message translates to:
  /// **'Check-out Date'**
  String get checkOutDate;

  /// No description provided for @numberOfGuests.
  ///
  /// In en, this message translates to:
  /// **'Number of Guests'**
  String get numberOfGuests;

  /// No description provided for @messageToOwner.
  ///
  /// In en, this message translates to:
  /// **'Message to Owner (Optional)'**
  String get messageToOwner;

  /// No description provided for @messageHint.
  ///
  /// In en, this message translates to:
  /// **'Add any special requests or questions...'**
  String get messageHint;

  /// No description provided for @pricePerNightLabel.
  ///
  /// In en, this message translates to:
  /// **'Price per night:'**
  String get pricePerNightLabel;

  /// No description provided for @numberOfNights.
  ///
  /// In en, this message translates to:
  /// **'Number of nights:'**
  String get numberOfNights;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total:'**
  String get total;

  /// No description provided for @submitBookingRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Booking Request'**
  String get submitBookingRequest;

  /// No description provided for @myBookings.
  ///
  /// In en, this message translates to:
  /// **'My Bookings'**
  String get myBookings;

  /// No description provided for @requested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get requested;

  /// No description provided for @pendingPayment.
  ///
  /// In en, this message translates to:
  /// **'Pending Payment'**
  String get pendingPayment;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @noBookings.
  ///
  /// In en, this message translates to:
  /// **'No {status} bookings'**
  String noBookings(Object status);

  /// No description provided for @noBookingsMessage.
  ///
  /// In en, this message translates to:
  /// **'Your {status} bookings will appear here'**
  String noBookingsMessage(Object status);

  /// No description provided for @bookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// No description provided for @property.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get property;

  /// No description provided for @bookingDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetailsTitle;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get checkOut;

  /// No description provided for @nights.
  ///
  /// In en, this message translates to:
  /// **'Nights'**
  String get nights;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timeline;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// No description provided for @guestsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No guests} one {1 guest} other {{count} guests}}'**
  String guestsLabel(num count);

  /// No description provided for @bookingTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get bookingTimelineTitle;

  /// No description provided for @bookingTimelineRequested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get bookingTimelineRequested;

  /// No description provided for @bookingTimelineAccepted.
  ///
  /// In en, this message translates to:
  /// **'Owner accepted'**
  String get bookingTimelineAccepted;

  /// No description provided for @bookingTimelinePendingPayment.
  ///
  /// In en, this message translates to:
  /// **'Pending payment'**
  String get bookingTimelinePendingPayment;

  /// No description provided for @bookingTimelineConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get bookingTimelineConfirmed;

  /// No description provided for @contactOwner.
  ///
  /// In en, this message translates to:
  /// **'Contact Owner'**
  String get contactOwner;

  /// No description provided for @viewProperty.
  ///
  /// In en, this message translates to:
  /// **'View Property'**
  String get viewProperty;

  /// No description provided for @ownerBookings.
  ///
  /// In en, this message translates to:
  /// **'Owner Bookings'**
  String get ownerBookings;

  /// No description provided for @incomingRequests.
  ///
  /// In en, this message translates to:
  /// **'Incoming Requests'**
  String get incomingRequests;

  /// No description provided for @activeBookings.
  ///
  /// In en, this message translates to:
  /// **'Active Bookings'**
  String get activeBookings;

  /// No description provided for @noIncomingRequests.
  ///
  /// In en, this message translates to:
  /// **'No incoming requests'**
  String get noIncomingRequests;

  /// No description provided for @noIncomingRequestsMessage.
  ///
  /// In en, this message translates to:
  /// **'New booking requests will appear here'**
  String get noIncomingRequestsMessage;

  /// No description provided for @noActiveBookings.
  ///
  /// In en, this message translates to:
  /// **'No active bookings'**
  String get noActiveBookings;

  /// No description provided for @noActiveBookingsMessage.
  ///
  /// In en, this message translates to:
  /// **'Your confirmed bookings will appear here'**
  String get noActiveBookingsMessage;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @bookingAccepted.
  ///
  /// In en, this message translates to:
  /// **'Booking accepted'**
  String get bookingAccepted;

  /// No description provided for @bookingRejected.
  ///
  /// In en, this message translates to:
  /// **'Booking rejected'**
  String get bookingRejected;

  /// No description provided for @messageFromGuest.
  ///
  /// In en, this message translates to:
  /// **'Message from guest:'**
  String get messageFromGuest;

  /// No description provided for @requestedTimeAgo.
  ///
  /// In en, this message translates to:
  /// **'Requested {timeAgo}'**
  String requestedTimeAgo(Object timeAgo);

  /// No description provided for @confirmedTimeAgo.
  ///
  /// In en, this message translates to:
  /// **'Confirmed {timeAgo}'**
  String confirmedTimeAgo(Object timeAgo);

  /// No description provided for @paymentRequired.
  ///
  /// In en, this message translates to:
  /// **'Payment Required'**
  String get paymentRequired;

  /// No description provided for @paymentRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Complete payment to confirm booking'**
  String get paymentRequiredMessage;

  /// No description provided for @waitingForOwner.
  ///
  /// In en, this message translates to:
  /// **'Waiting for owner response'**
  String get waitingForOwner;

  /// No description provided for @bookingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Your booking is confirmed'**
  String get bookingConfirmed;

  /// No description provided for @stayCompleted.
  ///
  /// In en, this message translates to:
  /// **'Your stay has been completed'**
  String get stayCompleted;

  /// No description provided for @bookingCancelled.
  ///
  /// In en, this message translates to:
  /// **'Booking cancelled'**
  String get bookingCancelled;

  /// No description provided for @paymentExpired.
  ///
  /// In en, this message translates to:
  /// **'Payment deadline has passed'**
  String get paymentExpired;

  /// No description provided for @bookingRequestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Booking request submitted'**
  String get bookingRequestSubmitted;

  /// No description provided for @ownerAcceptedRequest.
  ///
  /// In en, this message translates to:
  /// **'Owner accepted your request'**
  String get ownerAcceptedRequest;

  /// No description provided for @paymentRequiredWithin30.
  ///
  /// In en, this message translates to:
  /// **'Payment required within 30 minutes'**
  String get paymentRequiredWithin30;

  /// No description provided for @bookingConfirmedAfterPayment.
  ///
  /// In en, this message translates to:
  /// **'Booking confirmed after payment'**
  String get bookingConfirmedAfterPayment;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @writeReview.
  ///
  /// In en, this message translates to:
  /// **'Write Review'**
  String get writeReview;

  /// No description provided for @writeFirstReview.
  ///
  /// In en, this message translates to:
  /// **'Write First Review'**
  String get writeFirstReview;

  /// No description provided for @reviewPropertyTitle.
  ///
  /// In en, this message translates to:
  /// **'Review {propertyName}'**
  String reviewPropertyTitle(Object propertyName);

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @shareYourExperience.
  ///
  /// In en, this message translates to:
  /// **'Share your experience with this property...'**
  String get shareYourExperience;

  /// No description provided for @commentRequired.
  ///
  /// In en, this message translates to:
  /// **'Please add a comment'**
  String get commentRequired;

  /// No description provided for @commentTooShort.
  ///
  /// In en, this message translates to:
  /// **'Comment must be at least 10 characters'**
  String get commentTooShort;

  /// No description provided for @submitReview.
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submitReview;

  /// No description provided for @reviewSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Review submitted successfully!'**
  String get reviewSubmitted;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @noReviews.
  ///
  /// In en, this message translates to:
  /// **'No reviews'**
  String get noReviews;

  /// No description provided for @beTheFirstToReview.
  ///
  /// In en, this message translates to:
  /// **'Be the first to share your experience'**
  String get beTheFirstToReview;

  /// No description provided for @starsLabel.
  ///
  /// In en, this message translates to:
  /// **'stars'**
  String get starsLabel;

  /// No description provided for @ratingSlider.
  ///
  /// In en, this message translates to:
  /// **'Rating slider'**
  String get ratingSlider;

  /// No description provided for @outOfFive.
  ///
  /// In en, this message translates to:
  /// **'out of 5 stars'**
  String get outOfFive;

  /// No description provided for @manageUsers.
  ///
  /// In en, this message translates to:
  /// **'Manage Users'**
  String get manageUsers;

  /// No description provided for @manageProperties.
  ///
  /// In en, this message translates to:
  /// **'Manage Properties'**
  String get manageProperties;

  /// No description provided for @walletAdjustments.
  ///
  /// In en, this message translates to:
  /// **'Wallet Adjustments'**
  String get walletAdjustments;

  /// No description provided for @emailContentCopied.
  ///
  /// In en, this message translates to:
  /// **'Email content copied to clipboard'**
  String get emailContentCopied;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFilters;

  /// No description provided for @submitAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Submit Adjustment'**
  String get submitAdjustment;

  /// No description provided for @adjustmentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Adjustment Successful'**
  String get adjustmentSuccessful;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @rejectProperty.
  ///
  /// In en, this message translates to:
  /// **'Reject Property'**
  String get rejectProperty;

  /// No description provided for @pleaseProvideReason.
  ///
  /// In en, this message translates to:
  /// **'Please provide a reason for rejection'**
  String get pleaseProvideReason;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancelBooking;

  /// No description provided for @keepBooking.
  ///
  /// In en, this message translates to:
  /// **'Keep Booking'**
  String get keepBooking;

  /// No description provided for @userActionCompleted.
  ///
  /// In en, this message translates to:
  /// **'User {name} has been {action}'**
  String userActionCompleted(Object action, Object name);

  /// No description provided for @userPromoted.
  ///
  /// In en, this message translates to:
  /// **'User {name} has been promoted'**
  String userPromoted(Object name);

  /// No description provided for @userDemoted.
  ///
  /// In en, this message translates to:
  /// **'User {name} has been demoted'**
  String userDemoted(Object name);

  /// No description provided for @adminPropertiesManagement.
  ///
  /// In en, this message translates to:
  /// **'Admin Properties Management'**
  String get adminPropertiesManagement;

  /// No description provided for @confirmWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Confirm Withdrawal'**
  String get confirmWithdrawal;

  /// No description provided for @withdrawalRequested.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Requested'**
  String get withdrawalRequested;

  /// No description provided for @bookingSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Booking Submitted'**
  String get bookingSubmitted;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @modifyDates.
  ///
  /// In en, this message translates to:
  /// **'Modify Dates'**
  String get modifyDates;

  /// No description provided for @leaveReview.
  ///
  /// In en, this message translates to:
  /// **'Leave Review'**
  String get leaveReview;

  /// No description provided for @creditDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Credit/Debit Card'**
  String get creditDebitCard;

  /// No description provided for @cardTypes.
  ///
  /// In en, this message translates to:
  /// **'Visa, Mastercard, American Express'**
  String get cardTypes;

  /// No description provided for @bankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bankTransfer;

  /// No description provided for @directBankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Direct bank transfer'**
  String get directBankTransfer;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @pleaseWaitProcessing.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we process your top-up request.'**
  String get pleaseWaitProcessing;

  /// No description provided for @topupSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Top-up Successful'**
  String get topupSuccessful;

  /// No description provided for @topupFailed.
  ///
  /// In en, this message translates to:
  /// **'Top-up Failed'**
  String get topupFailed;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @languageChanged.
  ///
  /// In en, this message translates to:
  /// **'Language changed to {language}'**
  String languageChanged(Object language);

  /// No description provided for @themeChanged.
  ///
  /// In en, this message translates to:
  /// **'Theme changed to {theme}'**
  String themeChanged(Object theme);

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @changeAvatar.
  ///
  /// In en, this message translates to:
  /// **'Change Avatar'**
  String get changeAvatar;

  /// No description provided for @chooseAvatarOption.
  ///
  /// In en, this message translates to:
  /// **'Choose an avatar option:'**
  String get chooseAvatarOption;

  /// No description provided for @editPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Edit Phone Number'**
  String get editPhoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number:'**
  String get enterPhoneNumber;

  /// No description provided for @exploreProperties.
  ///
  /// In en, this message translates to:
  /// **'Explore Properties'**
  String get exploreProperties;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @bookAgain.
  ///
  /// In en, this message translates to:
  /// **'Book Again'**
  String get bookAgain;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully!'**
  String get passwordResetSuccess;

  /// No description provided for @errorCreatingBooking.
  ///
  /// In en, this message translates to:
  /// **'Error creating booking: {error}'**
  String errorCreatingBooking(Object error);

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @legalInformation.
  ///
  /// In en, this message translates to:
  /// **'Legal Information'**
  String get legalInformation;

  /// No description provided for @topUp.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get topUp;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @transactionDetails.
  ///
  /// In en, this message translates to:
  /// **'Transaction: {title}'**
  String transactionDetails(Object title);

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @accountDeletionRequested.
  ///
  /// In en, this message translates to:
  /// **'Account deletion requested'**
  String get accountDeletionRequested;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @welcomeToMaawa.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Maawa'**
  String get welcomeToMaawa;

  /// No description provided for @maawaDescription.
  ///
  /// In en, this message translates to:
  /// **'Maawa is your trusted platform for discovering and booking amazing properties. Whether you\'re looking for a cozy apartment, a luxury villa, or a unique stay, we connect you with the perfect accommodation for your needs.'**
  String get maawaDescription;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @smartSearch.
  ///
  /// In en, this message translates to:
  /// **'Smart Search'**
  String get smartSearch;

  /// No description provided for @smartSearchDescription.
  ///
  /// In en, this message translates to:
  /// **'Find properties with advanced filters and AI recommendations'**
  String get smartSearchDescription;

  /// No description provided for @secureBooking.
  ///
  /// In en, this message translates to:
  /// **'Secure Booking'**
  String get secureBooking;

  /// No description provided for @secureBookingDescription.
  ///
  /// In en, this message translates to:
  /// **'Safe and secure payment processing with instant confirmation'**
  String get secureBookingDescription;

  /// No description provided for @support247.
  ///
  /// In en, this message translates to:
  /// **'24/7 Support'**
  String get support247;

  /// No description provided for @support247Description.
  ///
  /// In en, this message translates to:
  /// **'Round-the-clock customer support for all your needs'**
  String get support247Description;

  /// No description provided for @verifiedProperties.
  ///
  /// In en, this message translates to:
  /// **'Verified Properties'**
  String get verifiedProperties;

  /// No description provided for @verifiedPropertiesDescription.
  ///
  /// In en, this message translates to:
  /// **'All properties are verified and reviewed by our team'**
  String get verifiedPropertiesDescription;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @supportEmail.
  ///
  /// In en, this message translates to:
  /// **'support@maawa.com'**
  String get supportEmail;

  /// No description provided for @supportPhone.
  ///
  /// In en, this message translates to:
  /// **'+1 (555) 123-4567'**
  String get supportPhone;

  /// No description provided for @supportWebsite.
  ///
  /// In en, this message translates to:
  /// **'www.maawa.com'**
  String get supportWebsite;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2024 Maawa. All rights reserved.'**
  String get copyright;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @manageNotifications.
  ///
  /// In en, this message translates to:
  /// **'Manage your notification preferences'**
  String get manageNotifications;

  /// No description provided for @locationServices.
  ///
  /// In en, this message translates to:
  /// **'Location Services'**
  String get locationServices;

  /// No description provided for @locationServicesDescription.
  ///
  /// In en, this message translates to:
  /// **'Help us find properties near you'**
  String get locationServicesDescription;

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecurity;

  /// No description provided for @readPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Read our privacy policy'**
  String get readPrivacyPolicy;

  /// No description provided for @readTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Read our terms and conditions'**
  String get readTermsOfService;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @updateAccountPassword.
  ///
  /// In en, this message translates to:
  /// **'Update your account password'**
  String get updateAccountPassword;

  /// No description provided for @deleteAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account'**
  String get deleteAccountDescription;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @getHelpSupport.
  ///
  /// In en, this message translates to:
  /// **'Get help and support'**
  String get getHelpSupport;

  /// No description provided for @sendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get sendFeedback;

  /// No description provided for @helpUsImprove.
  ///
  /// In en, this message translates to:
  /// **'Help us improve the app'**
  String get helpUsImprove;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate the App'**
  String get rateApp;

  /// No description provided for @rateOnAppStore.
  ///
  /// In en, this message translates to:
  /// **'Rate us on the app store'**
  String get rateOnAppStore;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @styleGuideDevTools.
  ///
  /// In en, this message translates to:
  /// **'Style guide and development tools'**
  String get styleGuideDevTools;

  /// No description provided for @appVersionInfo.
  ///
  /// In en, this message translates to:
  /// **'App version and information'**
  String get appVersionInfo;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// No description provided for @currentSettings.
  ///
  /// In en, this message translates to:
  /// **'Current Settings'**
  String get currentSettings;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @designSystem.
  ///
  /// In en, this message translates to:
  /// **'Design System'**
  String get designSystem;

  /// No description provided for @componentLibrary.
  ///
  /// In en, this message translates to:
  /// **'Component library and design tokens'**
  String get componentLibrary;

  /// No description provided for @themePreview.
  ///
  /// In en, this message translates to:
  /// **'Theme Preview'**
  String get themePreview;

  /// No description provided for @previewLightDark.
  ///
  /// In en, this message translates to:
  /// **'Preview light and dark themes'**
  String get previewLightDark;

  /// No description provided for @debugTools.
  ///
  /// In en, this message translates to:
  /// **'Debug Tools'**
  String get debugTools;

  /// No description provided for @testOverflowScenarios.
  ///
  /// In en, this message translates to:
  /// **'Test overflow scenarios and text scaling'**
  String get testOverflowScenarios;

  /// No description provided for @routeInspector.
  ///
  /// In en, this message translates to:
  /// **'Route Inspector'**
  String get routeInspector;

  /// No description provided for @viewRouteDetails.
  ///
  /// In en, this message translates to:
  /// **'View current route details and copy URLs'**
  String get viewRouteDetails;

  /// No description provided for @navigationTesting.
  ///
  /// In en, this message translates to:
  /// **'Navigation Testing'**
  String get navigationTesting;

  /// No description provided for @testTenantNavigation.
  ///
  /// In en, this message translates to:
  /// **'Test tenant navigation flow'**
  String get testTenantNavigation;

  /// No description provided for @testOwnerManagement.
  ///
  /// In en, this message translates to:
  /// **'Test owner property management'**
  String get testOwnerManagement;

  /// No description provided for @testAdminDashboard.
  ///
  /// In en, this message translates to:
  /// **'Test admin dashboard'**
  String get testAdminDashboard;

  /// No description provided for @debugInformation.
  ///
  /// In en, this message translates to:
  /// **'Debug Information'**
  String get debugInformation;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @flutterVersion.
  ///
  /// In en, this message translates to:
  /// **'Flutter Version'**
  String get flutterVersion;

  /// No description provided for @buildMode.
  ///
  /// In en, this message translates to:
  /// **'Build Mode'**
  String get buildMode;

  /// No description provided for @platform.
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get platform;

  /// No description provided for @networkConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Network Configuration'**
  String get networkConfiguration;

  /// No description provided for @baseUrl.
  ///
  /// In en, this message translates to:
  /// **'Base URL'**
  String get baseUrl;

  /// No description provided for @networkStatus.
  ///
  /// In en, this message translates to:
  /// **'Network Status'**
  String get networkStatus;

  /// No description provided for @apiVersion.
  ///
  /// In en, this message translates to:
  /// **'API Version'**
  String get apiVersion;

  /// No description provided for @environment.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get environment;

  /// No description provided for @switchBetweenRoles.
  ///
  /// In en, this message translates to:
  /// **'Switch between different user roles to test UI variations'**
  String get switchBetweenRoles;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// No description provided for @confirmDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.'**
  String get confirmDeleteAccount;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmation;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
