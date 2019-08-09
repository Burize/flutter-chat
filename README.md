# Mobile chat

Mobile chat written on [Flutter](https://flutter.dev/).
> There are not separate user dialogs at that moment - all users are in the same dialog(room).

## Features
- SignIn/SignUp by login(phone number) and password;
- Editing user profile: name, phone, avatar;
- Sending/receiving message between user via sockets;

## Getting Started

It is an flutter application, so first of all you need to [install it](https://flutter.dev/docs/get-started).
> No need to install emulators, you can run the project on a real device connected to a computer.

After successful installation, you can run project by `flutter run` command.

Then, you need deploy [server](https://github.com/Burize/chat-backend) for authentication and receiving message.