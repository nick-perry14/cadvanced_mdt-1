import axios from 'axios';

export default {
    methods: {
        // Handler for sending messages to client Lua
        sendClientMessage(path, payload) {
            axios.post(
                `http://cadvanced_mdt/${path}`,
                payload ? JSON.stringify(payload) : null
            );
        }
    }
};
