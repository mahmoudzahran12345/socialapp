abstract class SocialLoginStates{

}
class SocialLoginInatialState extends SocialLoginStates{}
class SocialLoginLoadingState extends SocialLoginStates{}
class SocialLoginSuccessfulState extends SocialLoginStates{
 final String uId;

 SocialLoginSuccessfulState(this.uId);
}
class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}
class SocialCreateLoadingState extends SocialLoginStates{}

class ChangePassword extends SocialLoginStates{}
class opencemary1 extends SocialLoginStates{}
class openGallary2 extends SocialLoginStates{}