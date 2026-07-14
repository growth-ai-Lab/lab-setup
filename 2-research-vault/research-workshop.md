# growth.ai Lab — Research Vault Workshop

A step-by-step guide to build a shared, citation-first research vault, put a research agent to work in it, optionally bridge it to your personal agent, and extend it with a deep dive.

Everything runs on one plugin, `growth-ai-lab`, and three skills inside it: `kb-init`, `kb-vault-attach`, and `kb-deep-dive`.

---

## What you'll need (5 min)

- [ ] **Joining from your Cloud PC?** Join the workshop call via Teams: https://www.microsoft.com/en-us/microsoft-teams/join-a-meeting
- [ ] **Install the plugin.** Open the plugin marketplace, find `growth-ai-lab` (it's browsable for everyone in the org), and install it.
- [ ] **Download the starter vault.** Get the seed `.zip` here: https://github.com/growth-ai-Lab/lab-setup/tree/main/2-research-vault. Do **not** unzip it manually — `kb-init` unpacks and verifies it for you.
- [ ] **Attach a personal agent.** If you've already run `setup-agent` in a separate vault, you can bridge it in Part 2.

---

## Part 1 — Download and initialise the research agent

*Uses the `kb-init` skill. Sets up both the **vault** (the knowledge base you own) and the **agent** that maintains it.*

**Step 1 — Connect a folder you own.**
Connect a folder to hold the vault — one that's yours, not inside any project folder. Its name becomes your vault name.

**Step 2 — Start the skill.**
In a new conversation, say:
```
initialise my research vault from this seed
```
Attach or point to the seed `.zip` you downloaded. Add your Obsidian folder (not the personal agent vault)

**Step 3 — Let it unpack and verify.**
Claude extracts the zip and checks every file against the seed manifest. If something's missing it will stop and tell you — that's expected behaviour, not an error. Don't edit the extracted files yourself.

**Step 4 — Setup agent.**
Respond to claude's questions: what to call the research agent, what it should call you, and confirmation of the vault name.

The setup will also ask you who else will write to the vault. If you have initialised a personal agent, enter the name of that agent here.

**Step 5 — Personal setup.**
Company name + one-liner, primary industry, which product areas/markets to map first.

**Step 7 — Set the maintenance loop.**
Claude explains how stale dates and contradictions get flagged. Optionally schedule a health sweep.

✅ **Done when:** you have a vault you own, a named agent, and a first Source → Knowledge → Hypothesis chain.

---

## Part 2 — Bridge to your personal agent *(optional)*

*Uses the `kb-vault-attach` skill. Skip if you don't have a personal agent from `setup-agent`.*

This lets **one** agent operate both its **personal memory vault** and the **research vault** without mixing the two.

**Step 1 — Check both pieces exist.**
A bootstrapped personal agent (from `setup-agent`) **and** the research vault from Part 1. Missing the agent? Run `setup-agent` first. Missing the vault? Go back to Part 1.

**Step 2 — Connect both folders** to the same conversation.

**Step 3 — Start the skill.**
```
attach my research vault to my personal agent
```

**Step 4 — Let it learn the contract and write the bridge.**
Claude reads the research vault's conventions, then **appends** a boot addendum to your agent's `CLAUDE.md`. It never touches your existing personal-memory steps, and re-running it won't duplicate anything.

**Step 5 — Verify.**
Claude smoke-tests by listing the research vault's entry points. Confirm it can reach both spaces.

> **To detach later:** remove the delimited block from `CLAUDE.md` and disconnect the folder.

✅ **Done when:** your agent switches into evidence-first mode inside the research vault while keeping personal memory separate.

---

## Part 3 — Deep dive to extend the vault

*Uses the `kb-deep-dive` skill. Builds on what's already in the vault — it doesn't research beside it.*

**Step 1 — Pick your topic and set the goal.**
Decide what the dive is *for* and how deep to go.
> Workshop topic (or choose your own): `[[SUGGESTED DEEP-DIVE TOPIC]]`

**Step 2 — Start the skill.**
```
do a deep dive on [[YOUR TOPIC]] and add it to the research vault
```

**Step 3 — Answer the scoping questions.**
Claude may ask 1–3 questions to pin down what the dive should inform and what's in/out of scope. Answer tightly.

**Step 4 — Let it work.**
Claude reads what the vault already knows, names the gaps, researches only those, and folds findings back in using the vault's own conventions — every claim cited, every figure scoped, contradictions flagged rather than overwritten.

**Step 5 — Read the briefing.**
Claude ends with a short synthesis: what was already known, what it added (and where), what it flagged, what's still open, and a suggested next dive.

✅ **Done when:** the vault is deeper on your topic and you've read the briefing of what changed.

---

## The one rule behind all three skills

The vault is **shared and governed**, so provenance is never optional: every claim cites a source, every figure carries its date and geography/scope, contradictions are flagged not rewritten, and nothing is marked `verified` without a live-source check. That's what lets teammates and future agents trust and build on the vault.

## Quick reference

| Goal | Skill | Say |
|------|-------|-----|
| Set up vault + agent | `kb-init` | *"initialise my research vault from this seed"* |
| Bridge a personal agent | `kb-vault-attach` | *"attach my research vault to my personal agent"* |
| Extend a topic | `kb-deep-dive` | *"do a deep dive on X and add it to the vault"* |

- Plugin: browsable in the org marketplace as `growth-ai-lab`
- Starter vault (seed zip): https://github.com/growth-ai-Lab/lab-setup/tree/main/2-research-vault
- Help: `[[SUPPORT CHANNEL]]`
