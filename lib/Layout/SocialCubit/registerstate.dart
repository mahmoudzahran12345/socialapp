abstract class SocialRegister {

}
class SocialRegisterInatialState extends SocialRegister{}
class SocialRegisterLoadingState extends SocialRegister{}
class SocialRegisterSuccessfulState extends SocialRegister{

}
class SocialRegisterErrorState extends SocialRegister{
  final String error;
  SocialRegisterErrorState(this.error);
}
class SocialCreateSuccessfulState extends SocialRegister{

}
class SocialCreateErrorState extends SocialRegister{
  final String error;
  SocialCreateErrorState(this.error);
}


class changepasswordRegister extends SocialRegister{}