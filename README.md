# Suricata Lab Kit | Configuration-validation prototype

**Current scope:** a minimal `configs/suricata.yaml` placeholder and `scripts/10_validate_suricata.sh`, intended to demonstrate configuration validation. The checked-in YAML describes itself as a *stub*. **This is not a deployable or tested production IDS configuration, ruleset-management platform, or training-data package.**

## Defensive purpose

Suricata can detect relevant network traffic in an authorized sensor environment, with rule alerts useful for SOC triage. Config and rule validation reduce the chance of deploying malformed settings; passing a syntax test does **not** establish detection coverage or sensor safety.

## Inspect before validation

- [Configuration stub](configs/suricata.yaml): a small illustrative YAML, not a full network interface and output deployment.
- [Validation helper](scripts/10_validate_suricata.sh): requires the Suricata binary and a readable configuration; executes `suricata -T -c "$CFG" -S /dev/null`, failing when tests fail.
- CI/workflow files are scaffolding and should not be presented as test evidence until checked runs demonstrate actual behavior.

## Reproducible syntax check (disposable VM only)

Set `CFG` to an explicit, reviewed Suricata configuration in an approved lab directory, then run:

```bash
set -Eeuo pipefail
command -v suricata
suricata --build-info
: "${CFG:?Set CFG to an existing reviewed config path}"
test -f "$CFG"
bash scripts/10_validate_suricata.sh
```

**Expected:** the helper prints `Suricata config validation ok.` only when Suricata's `-T` process exits successfully. It must fail on missing config. This expectation has not been verified on a lab sensor in this review. The committed stub may require additional parameters and should not be deployed blindly.

## Next development milestones

- [ ] Include safe complete sensor configuration documented for a disposable VM
- [ ] Add synthetic PCAP samples with known expected EVE JSON alerts
- [ ] Add deterministic alert/no-alert tests and minimum compatible Suricata version
- [ ] Pin/download detection rules from trusted sources with integrity checks and licensing
- [ ] Document runtime privileges, packet capture interface and data retention/security
- [ ] Publish sanitized EVE/fast.log sample outputs and a readable analyst triage walk-through

Until these milestones exist, label the repo a *configuration validation prototype*, not an operational detection deployment.
