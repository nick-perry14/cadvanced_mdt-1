<template>
    <button :style="{ background: colour }" type="button">{{ text }}</button>
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
        }
    }
};
</script>

<style scoped>
button {
    font-size: 13px;
    letter-spacing: 0.1em;
    min-width: 50px;
    height: 20px;
    border-radius: 4px;
    text-transform: uppercase;
    border: 0;
    color: #fff;
    margin: 0 2px;
    cursor: pointer;
}
button:first-child {
    margin-left: 0;
}
button:last-child {
    margin-right: 0;
}
</style>
