export default {
    created: function() {
        // Create listener for incoming messages coming from
        // client Lua
        window.addEventListener('message', event => this.processMessage(event));
    },
    destroyed: function() {
        // Destroy listener for incoming messages coming from
        // client Lua
        window.removeEventListener('message', event =>
            this.processMessage(event)
        );
    },
    methods: {
        // Handler for incoming messages from client Lua
        // const event = new Event('message');event.data = {action:'showMdt'};window.dispatchEvent(event);
        processMessage() {
            console.log('PROCESSING MESSAGE ' + JSON.stringify(event.data));
            if (
                event.data.hasOwnProperty('action') &&
                event.data.action == 'showMdt'
            ) {
                this.$store.commit('setVisible');
            } else if (event.data.hasOwnProperty('data')) {
                console.log(event.data);
            }
        }
    }
};
