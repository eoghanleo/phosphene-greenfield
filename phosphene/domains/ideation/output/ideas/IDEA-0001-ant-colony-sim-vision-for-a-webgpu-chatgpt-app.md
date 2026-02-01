ID: IDEA-0001
IssueNumber: 38
Title: Ant colony sim vision for a WebGPU ChatGPT app
Status: Draft
Updated: 2026-02-01
Dependencies: RA-001

```text
[V-SCRIPT]:
create_idea.sh
```

## Problem / opportunity

- The ant colony sim request needs a compelling vision, tone, and experience for a WebGPU 3D voxel lifecycle sim delivered as a ChatGPT app, but the space is underspecified. There is no clear fantasy layer, player role, or learning loop defined yet.
- The opportunity is to position the experience as a conversational lab assistant that lets a user run, observe, and narrate multiple colony lifecycles. Each run can emphasize a different lens (ecology, engineering, narrative) without rebuilding the simulation core.
- We need divergent concepts that keep the core WebGPU voxel sim but change the framing, stakes, and progression. This stress-tests which vision best supports onboarding, retention, and narrative payoff.

## Input echo (trace)

- The brief calls for a compelling vision, tone, and experience for a WebGPU 3D voxel ant colony lifecycle sim as a ChatGPT app. It explicitly asks for divergent concepts and stress-tested framing options.
- The intent is an ideation test of an ant colony sim vision, not a finished product definition. That means we should surface hypotheses and open questions, not lock a single direction.

## Target user hypotheses

- Curious builders who want to tinker with systems and tweak parameters to see emergent behavior. They enjoy seeing causal links made explicit through overlays and explanations.
- Story-driven explorers who want a lifecycle narrative with emotional attachment to a colony or queen archetype. They value pacing, setbacks, and a sense of continuity across runs.
- Simulation learners who want guided observation prompts, run comparisons, and distilled insights. They need scaffolding that turns complex motion into digestible lessons.
- Creative sandbox users who want to choreograph ant behavior and colony architecture into visual stories or time-lapses. They want shareable artifacts and cinematic output.

## Next research questions

- Which framing drives sustained session loops: lab notebook, survival saga, architecture sandbox, or hybrid? We should test which intro narrative keeps users exploring beyond the first run.
- How should a conversational assistant pace and explain 3D voxel complexity to avoid overwhelming new users? We need to evaluate when to introduce overlays versus when to focus on spectacle.
- What lifecycle milestones are most legible and emotionally resonant in a voxel sim (e.g., founding, first brood, supersedure, collapse)? We need to test which milestones are readable without heavy UI.
- What is the minimum viable simulation fidelity to create emergent “wow” moments without massive GPU cost? Establish a baseline for acceptable emergent patterns.
- How much agency should users have over colony inputs (terrain, resources, threats) before novelty collapses? Identify the threshold where control reduces surprise.
- Which output artifacts should the ChatGPT app generate (summaries, time-lapse clips, data cards) to make sessions memorable? Validate what users share and revisit.

## Experience loop hypotheses

- Observe → Ask → Adjust → Observe: the assistant translates observations into a single next action so users keep iterating. This keeps the loop tight while still feeling exploratory.
- Run-to-run contrast: the assistant proposes a “next run” with one variable changed to highlight causal links. The loop becomes a comparison engine rather than a long, opaque session.
- Emotional anchor: the assistant frames a single “protagonist” (queen or worker cohort) to maintain narrative continuity. This preserves attachment even when runs reset.

## Concept linkages

- CAND-01 and CAND-02 serve the simulation learner hypothesis by foregrounding invisible systems. They keep the core sim intact while providing scaffolding and narrative interpretation.
- CAND-04 and CAND-05 serve story-driven explorers through continuity and guided pacing. They emphasize tone, character, and a sense of progress without changing mechanics.
- CAND-07 through CAND-09 serve creative sandbox users by offering cinematic output and run-to-run storytelling. They translate emergent behavior into shareable artifacts.

## Divergence enumeration (pure)

| CandID | Ring | Axes | OneLiner |
| --- | --- | --- | --- |
| CAND-01 | adjacent | mechanism,channel | “Colony Lab”: a guided systems lab where ChatGPT frames each run as a hypothesis test and prompts instrumentation overlays that explain causal chains. |
| CAND-02 | adjacent | mechanism,modality | “Thermal Lens”: runs are narrated through sensor overlays (heat, pheromone density) so invisible systems become legible while keeping the voxel spectacle. |
| CAND-03 | adjacent | channel,progression | “Colony Seasons”: the assistant schedules runs as seasonal chapters with unlockable milestones per lifecycle stage and recap narrations. |
| CAND-04 | orthogonal | business_model,user | “Queen’s Chronicle”: a narrative survival journey where you embody the queen and the assistant narrates lineage arcs with a serialized tone. |
| CAND-05 | orthogonal | user,progression | “Caretaker Mode”: the assistant is a mentor who guides a novice biologist with stepwise missions, checklists, and empathy prompts. |
| CAND-06 | orthogonal | constraint,channel | “Field Report”: the sim is framed as a documentary capture with generated reports, evidence boards, and short observation briefs. |
| CAND-07 | extrapolatory | constraint,modality | “Voxel Ant Orchestra”: a creative sandbox where users compose time-lapse performances and export cinematic clips with scripted camera beats. |
| CAND-08 | extrapolatory | modality,mechanism | “Pheromone Synth”: users paint pheromone fields directly and the colony responds in real time while the assistant explains emergent tactics. |
| CAND-09 | extrapolatory | channel,progression | “Ecosystem Storyboard”: the assistant composes a multi-run storyboard with contrasting colonies and outcome cards for each scene. |
| CAND-10 | extrapolatory | business_model,channel | “Ant Academy”: a coach-like experience with structured lessons, challenges, and performance grades tied to colony outcomes. |
| CAND-11 | extrapolatory | modality,user | “Micro RTS”: the colony is controlled through high-level intent commands and strategic priorities with clear intent-to-action traces. |
| CAND-12 | extrapolatory | constraint,mechanism | “Collapse Simulator”: focus on fragile balance, letting users trigger stressors and study failure cascades in a safe sandbox. |

## Stress-test enumeration (all candidates)

| CandID | FailureMode | ValueCore | Differentiator |
| --- | --- | --- | --- |
| CAND-01 | The lab framing feels clinical without satisfying “aha” moments or vivid spectacle. Users may disengage if it feels like a spreadsheet. | Run comparisons + parameter sweeps with clear deltas. | Metrics overlays and narrative prompts turn emergent behavior into readable insights without losing beauty. The assistant should translate charts into plain-language takeaways. |
| CAND-02 | Sensor overlays confuse new users or hide the beauty of the voxel sim. The visual stack could feel noisy and technical. | Make invisible systems legible quickly. | Multi-layer toggle views with guided narration and an “aesthetic first” default view. The assistant can stage overlays only when a question is asked. |
| CAND-03 | Seasonal pacing feels forced if the sim doesn’t change enough per chapter. The “season” metaphor could read as arbitrary. | A clear lifecycle arc with cliffhangers. | Story beats tied to simulated milestones rather than fixed time durations. The assistant frames each beat with a short recap and next hook. |
| CAND-04 | Narrative pacing stalls if lifecycle events are rare or unclear. Story beats might not land without visible changes. | Emotional attachment to colony arcs with clear milestones. | Conversational narrator reframes setbacks as story beats and adds stakes to routine behaviors. The assistant highlights small wins to maintain momentum. |
| CAND-05 | The mentor tone becomes patronizing or repetitive over time. Users may feel boxed in by the guidance. | Gentle onboarding + confidence-building. | Adaptive mission difficulty and reflective prompts that change with observed mastery. The assistant asks for permission before offering a new lesson. |
| CAND-06 | “Documentary” framing lacks interactivity and feels passive. The sim risks becoming a slideshow. | Highlight evidence and discoveries. | Evidence board generation from user-triggered snapshots and hypothesis notes. The assistant invites the user to label findings and challenge assumptions. |
| CAND-07 | Creative output feels shallow if the sim lacks visual expressiveness. The output could look samey across runs. | Make and share cinematic colony performances. | Chat-driven choreography and camera scripting layered on top of simulation. The assistant proposes shot lists tailored to emergent events. |
| CAND-08 | Direct painting bypasses the simulation and reduces emergent surprise. The system may feel like a toy rather than a sim. | Immediate cause-effect feedback. | Hard constraints preserve emergent behavior while allowing steering and explanation. The assistant surfaces trade-offs when the user “overrides” nature. |
| CAND-09 | Storyboard workflow is too heavy for casual sessions. The planning burden could outweigh play. | Compare contrasting colony runs quickly. | Auto-generated run summaries and contrast cards that keep the workflow lightweight. The assistant pre-fills the storyboard with default scenes. |
| CAND-10 | Academic framing becomes a “quiz app” and loses wonder. Over-assessment could kill curiosity. | Structured learning with goals. | Hands-on labs tied to stunning visuals and narrative hooks. The assistant rewards curiosity with optional deep dives. |
| CAND-11 | Strategy intent commands feel too abstract to feel like a sim. Users may not understand why ants behave differently. | High-level control without micromanagement. | Intent-to-action trace overlays explain how commands map to voxel behaviors. The assistant shows “before/after” moments to make control feel tangible. |
| CAND-12 | Failure focus feels bleak and discouraging. Users may avoid the experience after collapse. | Insight into fragility and resilience. | “Recoverability” modes let users explore fixes and alternate outcomes after collapse. The assistant reframes failure as a puzzle rather than an ending. |

## Revision passes

- Builder: expanded to 12 distinct framing layers while keeping the same core WebGPU voxel sim.
- Critic: clarified that divergence is about framing, not simulation scope; added failure modes per candidate and tightened the experience loops.

## Notes

- Grounded in RA-001 as the only upstream research input.
