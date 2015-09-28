function createResolution() {
  $("create-resolution").on("click", function() {
    var postParams = {
      post: {
        title: $("#post-title").val(),
        description: $("#post-description").val()
      }
    }
  })
}
