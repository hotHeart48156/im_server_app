final url = "http://192.168.43.184:8080";
final wsurl = "ws://192.168.43.184:8080";

final login =
    "/login"; //post request  recv{ "name":"username","password":"password"}
final register =
    "/register"; //post request  recv{ "name":"username","password":"password"}
final ws = "/ws";
final getUserByIdPath =
    "/get_user_by_id"; //recv{ "id":"userid"}       post request
final wsSendMessageToFriend =
    "/send_message_to_friend"; //  post request  recv{/send_message_to_friend/message/friendid/type(TEXT/BINARY)}
final wsSendMessageToRoom =
    "/send_message_to_room"; //  post request  recv{/send_message_to_room/message/roomt/ype(TEXT/BINARY)}
final addFriend = "/add_friend"; //post request  recv {"friend_id":"id"}
final listFriend = "/list_friend"; //post request  recv token
final deleteFriend = "/delete_friend"; //post request  recv {"friend_id":"id"}
final uploadBinaryMessage = "/upload_message_binary"; // post request  form file
final uploadAvater = "/upload_avater_image"; // post request  form file

final getAvaterImage = "/avater/"; // get request need add token
final getBinaryFile = "/binary/"; //get request need add token
final loginUrl = Uri.parse(url + login);
final registerUrl = Uri.parse(url + register);
final wsUrl = Uri.parse(wsurl + ws);
final getFriendListUrl = Uri.parse(url + listFriend);
