import $ from 'jquery';

function openForm() {
  document.getElementById("myForm").style.display = "block";
  document.getElementById("myForm1").style.display = "block";
}

function closeForm() {
  document.getElementById("myForm").style.display = "none";
  document.getElementById("myForm1").style.display = "none";
}

function openChatbox() {
  document.getElementById("chatbox").style.display = "block";
}

function closeChatbox() {
    document.getElementById("chatbox").style.display = "none";
}

$(() =>
  $('button#open-chatbox-button').on('click', () => openChatbox()),
  $('button#close-chatbox-button').on('click', () => closeChatbox()),
  $('button#open-form-button').on('click', () => openForm()),
  $('button#close-form-button').on('click', () => closeForm())
);
