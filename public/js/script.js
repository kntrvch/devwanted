$(function () {
  $(".nano").slimScroll({
    height: '600px'
  });
  $('.summernote').summernote({
    placeholder: 'Job description...',
    tabsize: 2,
    height: 200,
    toolbar: [
      ['style', ['bold', 'italic', 'underline']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['codeview'],
      ['fullscreen']
    ]
  });
  $("#logoButton").click(function () {
    console.log('cloudinary start');
    self = this;
    cloudinary.openUploadWidget({
      cloud_name: 'dmhmw9a8k',
      upload_preset: 'nqhgol54'
    }, function (error, result) {
      var thumbnailUrl = result[0].thumbnail_url || '';
      var imageUrl = result[0].secure_url || '';
      $(self).text("Change");
      $("#thumbnailUrl").val(thumbnailUrl);
      $("#imageUrl").val(imageUrl);
      $("#logoWrapper").html("<img src='" + thumbnailUrl + "' alt=''>");;
    });
  });
});