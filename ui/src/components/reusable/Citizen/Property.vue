<template>
    <div class="property-container">
        <span class="label" v-if="label && label.length > 0">
            {{ label }}:</span
        >
        {{ value || 'Unknown' }}
    </div>
</template>

<script>
export default {
    props: ['label', 'value']
};
</script>

<style scoped>
.label {
    font-weight: bold;
}
</style>
