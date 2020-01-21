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
            console.log(
                'NUI: PROCESSING MESSAGE ' + JSON.stringify(event.data)
            );
            if (
                event.data.hasOwnProperty('action') &&
                event.data.action == 'showMdt'
            ) {
                this.$store.commit('setVisible');
            } else if (event.data.hasOwnProperty('data')) {
                // Identify what sort of data we're receiving
                if (event.data.hasOwnProperty('object') && event.data.object) {
                    switch (event.data.object) {
                        case 'units':
                            console.log('NUI: RECEIVED UNITS');
                            this.$store.commit('setUnits', event.data.data);
                            break;
                        default:
                            console.log('NUI: Unknown object received');
                    }
                }
            }
        }
    }
};
