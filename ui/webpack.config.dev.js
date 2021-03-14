'use strict';

const webpack = require('webpack');
const { VueLoaderPlugin } = require('vue-loader');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const path = require('path');
require('babel-polyfill');

module.exports = {
    mode: 'development',
    entry: ['babel-polyfill', './src/index.js'],
    devServer: {
        contentBase: path.join(__dirname, 'public'),
        hot: true,
        host: '<hostname_here>',
        watchOptions: {
            poll: true,
        },
    },
    module: {
        rules: [
            {
                test: /\.vue$/,
                use: 'vue-loader',
            },
            {
                test: /\.css$/,
                use: ['vue-style-loader', 'css-loader'],
            },
            {
                test: /\.js$/,
                use: 'babel-loader',
            },
        ],
    },
    plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new VueLoaderPlugin(),
        new HtmlWebpackPlugin({
            filename: 'index.html',
            template: 'public/index.html',
            inject: true,
        }),
    ],
};
