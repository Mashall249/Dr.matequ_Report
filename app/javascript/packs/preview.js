$(document).on('turbolinks:load', function () {

  $('#image_input').on('change', function (event) {
    console.log('Image input changed');

    const file = event.target.files[0];

    if (file) {
      const reader = new FileReader();

      reader.onload = function (e) {
        console.log('File loaded');
        $('#image_preview').attr('src', e.target.result).show();
      };

      reader.readAsDataURL(file);
    } else {
      $('#image_preview').hide().attr('src', '');
    }
  });
});