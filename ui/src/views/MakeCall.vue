<template>
    <div v-if="isVisible" id="container">
        <div id="caller">
            <div id="title">
                <span class="fas fa-phone-alt" />
                <h1>Contact emergency services</h1>
            </div>
            <div id="dialer">
                <span v-if="connectState === 'connecting'"
                    >Dialing {{ number }}...</span
                >
            </div>
            <div id="content">
                <div id="call-details" v-if="connectState === 'connected'">
                    <input
                        type="text"
                        class="caller-input"
                        v-model="call.callerInfo"
                        placeholder="Caller information"
                    />
                    <v-select
                        placeholder="Location"
                        class="caller-input location-select"
                        v-model="call.location"
                        label="name"
                        :options="locationList"
                        @input="handleSelectUpdate"
                    />
                    <textarea
                        class="caller-input notes"
                        v-model="call.notes"
                        placeholder="Notes"
                    />
                    <div id="call-actions">
                        <button @click="closeCall()" type="button" id="cancel">
                            Hang up
                        </button>
                        <button
                            :disabled="submitDisabled"
                            @click="sendCall()"
                            type="button"
                            id="place-call"
                        >
                            Submit call
                        </button>
                    </div>
                </div>
                <div
                    id="connect"
                    v-if="connectState === 'disconnected' && !callSent"
                >
                    <button @click="doConnect()" type="button" id="place-call">
                        Dial {{ number }}
                    </button>
                    <button @click="closeCall()" type="button" id="cancel">
                        Cancel
                    </button>
                </div>
                <div
                    id="connect"
                    v-if="connectState === 'disconnected' && callSent"
                >
                    <p id="call-complete">Your call has been submitted</p>
                    <button @click="closeCall()" type="button" id="cancel">
                        Close
                    </button>
                </div>
            </div>
            <div id="footer">
                <div id="connect-status">
                    <span v-if="connectState === 'disconnected'"
                        >Disconnected</span
                    >
                    <span v-else-if="connectState === 'connecting'"
                        >Connecting...</span
                    >
                    <span v-else>Connected</span>
                </div>
                <div v-bind:class="[connectState]" id="connect-indicator"></div>
            </div>
        </div>
    </div>
</template>

<script>
import soundPlayer from '../mixins/soundPlayer';
import clientSender from '../mixins/clientSender';

function initState() {
    return {
        connectState: 'disconnected',
        callSent: false,
        call: {
            callerInfo: '',
            location: null,
            notes: ''
        }
    };
}

export default {
    data: function() {
        return initState();
    },
    mixins: [soundPlayer, clientSender],
    computed: {
        isVisible() {
            return this.$store.getters.isCallVisible;
        },
        submitDisabled() {
            return (
                this.call.callerInfo.length === 0 ||
                this.call.location === null ||
                this.call.notes.length === 0
            );
        },
        locationList() {
            return this.$store.getters.getLocations;
        }
    },
    watch: {
        isVisible(newVal) {
            this.resetState();
            if (newVal) {
                const conf = this.$store.getters.getResourceConfig;
                this.number = conf.call_number;
                this.ringFilename = conf.call_ring_filename;
                this.busyFilename = conf.call_busy_filename;
            }
        }
    },
    methods: {
        resetState() {
            Object.assign(this.$data, initState());
        },
        sendCall() {
            if (!this.submitDisabled) {
                this.sendClientMessage('citizenCall', {
                    ...this.call,
                    location: this.call.location.id
                });
                this.connectState = 'disconnected';
                this.callSent = true;
            }
        },
        handleSelectUpdate(val) {
            this.call.location = val;
        },
        closeCall() {
            this.connectState = 'disconnected';
            this.sendClientMessage('hideCall');
            this.$store.commit('setCallVisible', false);
        },
        getRandomInt(min, max) {
            const base = Math.floor(Math.random() * Math.floor(max - min));
            return base + min;
        },
        wait(ms) {
            return new Promise(resolve => {
                setTimeout(() => {
                    resolve(ms);
                }, ms);
            });
        },
        isBusy() {
            const check = this.getRandomInt(1, 10);
            return check > 5;
        },
        playDial() {
            const sounds = this.number
                .split('')
                .map(number => `./sounds/dtmf/${number}.ogg`);
            return this.playSounds(sounds);
        },
        playRing() {
            const ringCount = this.getRandomInt(3, 6);
            const sounds = Array(ringCount).fill('./sounds/ringing_uk.ogg');
            return this.playSounds(sounds);
        },
        playBusy() {
            const sounds = Array(3).fill('./sounds/busy_uk.ogg');
            return this.playSounds(sounds);
        },
        async doConnect() {
            if (this.connectState !== 'disconnected') {
                return;
            }
            this.$data.connectState = 'connecting';
            await this.wait(2000);
            await this.playDial();
            await this.wait(this.getRandomInt(2, 4) * 1000);
            if (this.isBusy()) {
                await this.playBusy();
                this.$data.connectState = 'disconnected';
            } else {
                await this.playRing();
                this.$data.connectState = 'connected';
            }
        }
    }
};
</script>

<style scoped>
body,
input,
textarea,
button {
    font-family: 'Jura', sans-serif;
}
#container {
    display: flex;
    justify-content: center;
    padding-top: 20vh;
}
#caller {
    display: flex;
    flex-direction: column;
    letter-spacing: 0.1em;
    width: 400px;
    background: #4a4a4a;
    border: 3px solid #777;
    border-radius: 5px;
    opacity: 0.9;
    height: 60vh;
}
#title {
    padding: 30px 0;
    color: rgba(255, 255, 255, 0.8);
    text-align: center;
}
#title > * {
    display: block;
}
#title > span {
    margin: 0 0 20px 0;
    font-size: 30px;
    color: rgba(255, 255, 255, 0.5);
}
#title > h1 {
    font-size: 20px;
    text-transform: uppercase;
}
#dialer {
    font-family: 'VT323', sans-serif;
    font-size: 20px;
    color: rgba(0, 0, 0, 0.4);
    margin: 0 20px;
    border: 1px solid rgba(0, 0, 0, 0.5);
    padding: 8px;
    border-radius: 5px;
    background: rgba(255, 255, 255, 0.2);
    text-align: center;
    height: 1em;
}
#content {
    flex: 1;
    padding: 10px 20px;
}
#call-complete {
    color: rgba(255, 255, 255, 0.8);
    padding-bottom: 20px;
}
#call-details,
#connect {
    display: flex;
    flex-direction: column;
}
#connect {
    align-items: center;
    justify-content: center;
    height: 100%;
}
#connect button {
    margin: 10px 0;
}
#footer {
    padding: 10px 20px;
    background: rgba(0, 0, 0, 0.2);
    color: rgba(255, 255, 255, 0.8);
    display: flex;
    justify-content: flex-end;
}
#connect-indicator {
    width: 16px;
    height: 16px;
    border-radius: 8px;
    margin-left: 10px;
}
.disconnected {
    background: rgba(255, 0, 0, 0.4);
}
.connecting {
    background: rgba(255, 255, 0, 0.4);
}
.connected {
    background: rgba(0, 255, 0, 0.4);
}
.caller-input {
    display: block;
    border-radius: 5px;
    border: 1px solid rgba(255, 255, 255, 0.5);
    background: none;
    padding: 10px;
    outline: none;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 15px;
    letter-spacing: 0.12em;
    margin-top: 20px;
}
.notes {
    height: 100px;
    resize: none;
}
#call-actions {
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
}
button {
    width: 40%;
    background: none;
    border: 1px solid rgba(255, 255, 255, 0.5);
    border-radius: 5px;
    padding: 10px;
    font-size: 15px;
    font-weight: 500;
    text-transform: uppercase;
    color: rgba(255, 255, 255, 0.7);
}
#place-call,
#connect-button {
    background: rgba(0, 255, 0, 0.4);
}
#place-call:disabled {
    opacity: 0.5;
}
#cancel {
    background: rgba(255, 0, 0, 0.4);
}
.location-select {
    border: 0;
    padding: 10px 0;
}
.location-select >>> .vs__dropdown-toggle {
    border-radius: 5px;
    border: 1px solid rgba(255, 255, 255, 0.5);
    background: none;
    color: rgba(255, 255, 255, 0.5);
    font-size: 15px;
    letter-spacing: 0.12em;
}
.location-select >>> .vs__dropdown-menu {
    background: #4a4a4a;
    border: 2px solid rgba(255, 255, 255, 0.5);
    border-top: 0;
    color: rgba(255, 255, 255, 0.5);
    font-size: 15px;
    letter-spacing: 0.12em;
    overflow-x: hidden;
    overflow-y: auto;
}
.location-select >>> .vs__search,
.location-select >>> .vs__dropdown-option {
    color: rgba(255, 255, 255, 0.5);
    overflow-x: hidden;
}
.location-select >>> .vs__search::placeholder {
    color: rgba(255, 255, 255, 0.2);
}
.location-select >>> .vs__dropdown-option--highlight {
    background: rgba(0, 0, 0, 0.5);
}
.location-select >>> .vs__selected-options {
    overflow-x: hidden;
    overflow-y: hidden;
    white-space: nowrap;
}
.location-select >>> .vs__selected {
    color: rgba(255, 255, 255, 0.5);
}
.location-select >>> .vs__clear {
    fill: rgba(255, 255, 255, 0.5);
}
.location-select >>> .vs__open-indicator {
    fill: rgba(255, 255, 255, 0.5);
    margin-right: 10px;
}
</style>
