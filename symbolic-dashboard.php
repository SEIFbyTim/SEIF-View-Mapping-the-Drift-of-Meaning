<?php
/*
Plugin Name: Symbolic Propaganda Dashboard
Description: Displays a symbolic counter-propaganda response dashboard via shortcode.
Version: 1.0
Author: Tim Hauptrief
*/

defined('ABSPATH') or die('No script kiddies please!');

// Enqueue JS + CSS
add_action('wp_enqueue_scripts', function() {
    wp_enqueue_style('symbolic-dashboard-style', plugin_dir_url(__FILE__) . 'style.css');
    wp_enqueue_script('symbolic-dashboard-js', plugin_dir_url(__FILE__) . 'script.js', array(), null, true);
});

// Shortcode to render dashboard
add_shortcode('symbolic_dashboard', function() {
    ob_start(); ?>
    <div id="symbolic-dashboard">
        <h2>Symbolic Propaganda Countermeasure Dashboard</h2>
        <table>
            <thead>
                <tr>
                    <th>Source</th>
                    <th>Narrative</th>
                    <th>Symbol</th>
                    <th>NDI</th>
                    <th>HER</th>
                    <th>Kindling Tier</th>
                    <th>Kindling Reply</th>
                </tr>
            </thead>
            <tbody>
                <!-- JS inserts rows dynamically -->
            </tbody>
        </table>
    </div>
    <?php return ob_get_clean();
});
?>
