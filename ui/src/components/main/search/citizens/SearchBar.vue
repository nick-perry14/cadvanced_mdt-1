<template>
    <div id="search-bar">
        <div>
            <input type="text" id="search-first-name" />
        </div>
        <div>
            <input type="text" id="search-surname" />
        </div>
        <div>
            <input type="text" id="search-date-of-birth" />
        </div>
        <div>
            <input type="text" id="search-id" />
        </div>
    </div>
</template>

<style scoped>
#search-bar {
    display: flex;
    justify-content: space-between;
}
#search-bar > div {
    width: 300px;
    border: 1px solid red;
}
</style>
