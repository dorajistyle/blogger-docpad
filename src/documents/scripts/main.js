var EMAIL_REGEX = /^.+@[^.].*\.[a-z]{2,10}$/;

function showEmailForm() {
  var email_form = document.getElementById('sendEmailForm');
  if (email_form) {
      email_form.removeAttribute('hidden'); 
  }
  else {
      alert('Couldn\'t find the element.');
  }
}

function validateForm() {
            var $field = document.getElementById('entry_2021847284');
            var is_human = document.getElementById('group_1798525724_1').checked;
            var value = $field.value;
            var result = EMAIL_REGEX.test(value);
            //console.log('value : '+ value);
            //console.log('result : '+ result);
            if (!result) {
                alert("올바른 이메일 주소를 입력해 주세요.\n Please enter a valid email address.");
                $field.focus();
                return false;
            }
            if (!is_human) {
                alert("이메일을 전송하지 않았습니다. Email not sent.");
                return false;
            }
            //var $form =document.getElementById('sendEmailForm');
//            $form.setAttribute('action','https://docs.google.com/spreadsheet/formResponse?formkey=dExpMm05STR1OVQyWGJwZXJjWVl5aWc6MA&amp;ifq');
            return true;

}

function submitForm() {
    var $form =document.getElementById('sendEmailForm');
    if(validateForm()) {
          $form.setAttribute('action','https://docs.google.com/forms/d/1HmGMDB8jChW-LCPzZMfv7CWx1KE5PrbYZLk6CmmRrdo/formResponse');
          document.createElement('form').submit.call($form);
          $form.reset();
          $form.setAttribute('hidden','true');

    }
}

