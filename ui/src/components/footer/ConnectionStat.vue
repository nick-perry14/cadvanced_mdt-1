<template>
    <div id="connection_stat">
        <div id="connection_indicator" />
        <p>Connected to control</p>
    </div>
</template>

<style scoped>
div#connection_stat {
    flex: 1 1 0;
    display: flex;
}
div#connection_indicator {
    width: 24px;
    height: 24px;
    border-radius: 12px;
    background: rgba(82, 255, 0, 0.5);
    margin-right: 20px;
}
</style>
