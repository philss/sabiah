import {Socket} from "phoenix";

const userId = window.userId;

let socket = new Socket("/socket", {params: {userId: userId}});
socket.connect();

export default socket;
