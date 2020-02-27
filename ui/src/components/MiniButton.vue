<template>
    <button
        @click="emitClick"
        :style="{
            background: colour,
            border: borderColour ? '1px solid ' + borderColour : 0,
            fontSize: fontSize ? fontSize : 'unset'
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
    font-size: 13px;
    letter-spacing: 0.1em;
    min-width: 50px;
    border-radius: 4px;
    text-transform: uppercase;
    color: #fff;
    margin: 0 2px;
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
