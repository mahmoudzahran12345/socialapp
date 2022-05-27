abstract class SocialState {}
class SocialInitialState extends SocialState{}
class SocialLoadingStateGet extends SocialState{}
class SocialGetUserSuccessState extends SocialState{}
class SocialGetUserErrorState extends SocialState{
  final String error;
  SocialGetUserErrorState(this.error);
}
class changeNavigationBar extends SocialState{}
class changeGetsPost extends SocialState{}
class changeCoverImagesuccess extends SocialState{}
class changeCoverImageerror extends SocialState{}
class changeImagesuccess extends SocialState{}
class changeImageerror extends SocialState{}
class UploadImagesusses extends SocialState{}
class UploadImageerror extends SocialState{}
class UploadImagecoversusses extends SocialState{}
class UploadImagecovererror extends SocialState{}
class loadingimage extends SocialState{}
class updateusererror extends SocialState{}
class updateusersucces extends SocialState{}
class SocialCreatePostLoading extends SocialState{}
class SocialCreatePostError extends SocialState{}
class SocialCreatePostSuccess extends SocialState{}
class SocialGetImagePickerSuccess extends SocialState{}
class SocialGetImagePickerError extends SocialState{}
class SocialDeletePostImage extends SocialState{}
//////////////////////////////////////////////////////////////
class SocialGetPostLoading extends SocialState{}
class SocialGetPostSuccess extends SocialState{}
class SocialGetPostError extends SocialState{
  final String error;
  SocialGetPostError(this.error);
}
class SocialGetLikeLoading extends SocialState{}
class SocialGetLikeSuccess extends SocialState{}
class SocialGetLikeError extends SocialState{
  final String error;
  SocialGetLikeError(this.error);
}
///////////////////////////////////////////////////////
class SocialGetAllUsersLoading extends SocialState{}
class SocialGetAllUsersSuccess extends SocialState{}
class SocialGetAllUsersError extends SocialState{
  final String error;
  SocialGetAllUsersError(this.error);
}
//////////////////////////////////////////////////////////////////
class SocialSendMessageSuccess extends SocialState{}
class SocialSendMessageError extends SocialState{
  final String error;

  SocialSendMessageError(this.error);
}
class SocialGetMessageSuccess extends SocialState{}
class SocialGetMessageError extends SocialState{
  final String error;

  SocialGetMessageError(this.error);
}
















