<template>
    <button
        @click="emitClick"
        :style="{
            background: colour ? colour : 'rgba(0,0,0,0.1)',
            border: borderColour ? '1px solid ' + borderColour : 0,
            fontSize: fontSize ? fontSize : '13px',
            borderRadius: borderRadius ? borderRadius : '4px'
        }"
        type="button"
    >
        {{ text }}
    </button>
</template>

<script>
export default {
    props: {
        text: {
            type: String,
            required: true
        },
        colour: {
            type: String,
            required: true
        },
        borderColour: {
            type: String,
            required: false
        },
        borderRadius: {
            type: String,
            required: false
        },
        fontSize: {
            type: String,
            required: false
        }
    },
    methods: {
        emitClick() {
            this.$emit('miniClick');
        }
    }
};
</script>

<style scoped>
button {
    padding-bottom: 3px;
    letter-spacing: 0.1em;
    min-width: 50px;
    text-transform: uppercase;
    color: rgba(255, 255, 255, 0.8);
    margin: 0;
    cursor: pointer;
    white-space: nowrap;
}
button:first-child {
    margin-left: 0;
}
button:last-child {
    margin-right: 0;
}
</style>
