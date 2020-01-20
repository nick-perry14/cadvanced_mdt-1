import axios from 'axios';

export default {
    methods: {
        // Handler for sending messages to client Lua
        sendClientMessage(path, payload) {
            console.log('Sending message to ' + path);
            axios.post(
                `http://cadvanced_mdt/${path}`,
                payload ? JSON.stringify(payload) : null
            );
        }
    }
};
