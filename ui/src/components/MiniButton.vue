<template>
    <button v-bind:style="{ background: colour }" type="button">{{ text }}</button>
</template>

<script>
export default {
    props: ['text', 'colour', 'handler', 'is-disabled']
};
</script>

<style scoped>
button {
    font-size: 16px;
    letter-spacing: 0.1em;
    min-width: 85px;
    height: 27px;
    border-radius: 4px;
    text-transform: uppercase;
    border: 0;
    color: #fff;
    margin: 0 5px;
}
button:first-child {
    margin-left: 0;
}
button:last-child {
    margin-right: 0;
}
</style>