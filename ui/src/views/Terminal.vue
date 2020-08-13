<template>
    <div v-if="isDragging" id="terminal" :style="{ display: isVisible }" v-drag>
        <div id="header">Terminal</div>
        <Officer id="officer" />
        <div id="units-container">
            <Units />
        </div>
        <div id="end-drag">
            <MiniButton
                @miniClick="stopDragging()"
                text="Finish positioning terminal"
                colour="rgba(0,255,0,0.5)"
                borderRadius="3px"
                padding="6px 8px"
            />
        </div>
    </div>
    <div v-else id="terminal" :style="{ display: isVisible }">
        <div id="header">Terminal</div>
        <Officer id="officer" />
        <div id="units-container">
            <Units />
        </div>
    </div>
</template>

<script>
import drag from '@branu-jp/v-drag';
import clientSender from '../mixins/clientSender';
import Officer from '../components/footer/Officer.vue';
import Units from '../components/terminal/Units.vue';
import MiniButton from '../components/MiniButton.vue';

export default {
    directives: {
        drag
    },
    mixins: [clientSender],
    components: {
        Officer,
        Units,
        MiniButton
    },
    computed: {
        isVisible() {
            return this.$store.getters.isTerminalVisible ? 'block' : 'none';
        },
        isDragging() {
            return this.$store.getters.isTerminalDragging;
        }
    },
    methods: {
        stopDragging() {
            this.sendClientMessage('terminalDraggingStop');
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
#terminal {
    letter-spacing: 0.1em;
    position: absolute;
    width: 400px;
    background: #4a4a4a;
    border: 3px solid #777;
    border-radius: 5px;
    opacity: 0.9;
}
#header {
    padding: 5px;
    text-align: center;
    text-transform: uppercase;
    background: rgba(0, 0, 0, 0.5);
    color: rgba(255, 255, 255, 0.7);
    font-size: 20px;
}
#officer {
    padding: 5px;
    text-align: center;
    text-transform: uppercase;
    background: rgba(0, 0, 0, 0.3);
    color: rgba(255, 255, 255, 0.7);
    font-size: 15px;
    margin-bottom: 7px;
}
#end-drag {
    background: rgba(0, 0, 0, 0.5);
    text-align: center;
    padding: 0 20px 20px 20px;
}
</style>
