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
                    // Animate the "receiving" indicator
                    this.$store.commit('setConnectionIsActive');
                    switch (event.data.object) {
                        case 'units':
                            console.log('NUI: RECEIVED UNITS');
                            this.$store.commit('setUnits', event.data.data);
                            break;
                        case 'users':
                            console.log('NUI: RECEIVED USERS');
                            this.$store.commit('setUsers', event.data.data);
                            break;
                        case 'calls':
                            console.log('NUI: RECEIVED CALLS');
                            this.$store.commit('setCalls', event.data.data);
                            break;
                        case 'steam_id':
                            console.log('NUI: RECEIVED STEAM ID');
                            this.$store.commit('setSteamId', event.data.data);
                            break;
                        case 'search_results':
                            console.log('NUI: RECEIVED SEARCH RESULTS');
                            this.$store.commit(
                                'setCitizenSearchResults',
                                event.data.data
                            );
                            break;
                        case 'citizen_offences':
                            console.log('NUI: RECEIVED CITIZEN OFFENCES');
                            this.$store.commit(
                                'setCitizenOffences',
                                event.data.data
                            );
                            break;
                        default:
                            console.log('NUI: Unknown object received');
                    }
                }
            }
        }
    }
};
