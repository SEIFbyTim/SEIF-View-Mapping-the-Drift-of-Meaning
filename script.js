document.addEventListener("DOMContentLoaded", function () {
    const data = [
        {
            source: "RT via TikTok",
            narrative: "Western decline",
            symbol: "Hope",
            ndi: 0.89,
            her: 0.81,
            tier: "Ritual Marking",
            reply: "The fire flickers, but we do not shout at wind. Let hope rest."
        },
        {
            source: "Xinhua",
            narrative: "U.S. destabilizing Asia",
            symbol: "Memory",
            ndi: 0.76,
            her: 0.65,
            tier: "Silence",
            reply: "No answer is the cleanest truth when memory is bent."
        },
        {
            source: "Anonymous Telegram",
            narrative: "Elites control world events",
            symbol: "Reality",
            ndi: 0.91,
            her: 0.88,
            tier: "Silence + Alert",
            reply: "Silence marks what cannot be named. Let reality speak in echoes."
        },
        {
            source: "DoD",
            narrative: "China’s coercive behavior",
            symbol: "Security",
            ndi: 0.33,
            her: 0.27,
            tier: "Log & Archive",
            reply: "The sea reflects, but does not pull you in. This is simply noted."
        },
        {
            source: "TASS",
            narrative: "NATO provokes war",
            symbol: "Trust",
            ndi: 0.82,
            her: 0.74,
            tier: "Poetic Reflection",
            reply: "When trust is twisted, reflection returns it to its root."
        }
    ];

    const tbody = document.querySelector("#symbolic-dashboard tbody");

    data.forEach(entry => {
        const row = document.createElement("tr");
        row.innerHTML = `
            <td>${entry.source}</td>
            <td>${entry.narrative}</td>
            <td>${entry.symbol}</td>
            <td class="ndi" data-score="${entry.ndi}">${entry.ndi}</td>
            <td class="her" data-score="${entry.her}">${entry.her}</td>
            <td>${entry.tier}</td>
            <td>${entry.reply}</td>
        `;
        tbody.appendChild(row);
    });

    document.querySelectorAll(".ndi, .her").forEach(cell => {
        const score = parseFloat(cell.dataset.score);
        if (score >= 0.85) {
            cell.style.color = "red";
        } else if (score >= 0.65) {
            cell.style.color = "orange";
        } else {
            cell.style.color = "green";
        }
    });
});
