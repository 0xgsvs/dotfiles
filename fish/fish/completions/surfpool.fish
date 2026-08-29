Created file surfpool.fish
Check your shell's docs for how to enable completions for surfpool.

function __fish_surfpool_global_optspecs
    string join \n h/help V/version
end

function __fish_surfpool_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_surfpool_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_surfpool_using_subcommand
    set -l cmd (__fish_surfpool_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c surfpool -n "__fish_surfpool_needs_command" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_needs_command" -s V -l version -d 'Print version'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "start" -d 'Start a local Surfnet'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "completions" -d 'Generate shell completion scripts'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "run" -d 'Execute a runbook'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "ls" -d 'List runbooks in the current workspace'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "mcp" -d 'Start the Surfpool MCP server'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "update" -d 'Update Surfpool to the latest version'
complete -c surfpool -n "__fish_surfpool_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s p -l port -d 'Bind the JSON-RPC server to this port' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s w -l ws-port -d 'Bind the WebSocket server to this port' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s o -l host -d 'Bind RPC, WebSocket, and Studio services to this host' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s u -l rpc-url -d 'Fork from this datasource RPC URL' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s n -l network -d 'Fork from a predefined Solana network' -r -f -a "mainnet\t'Solana Mainnet-Beta (https://api.mainnet-beta.solana.com)'
devnet\t'Solana Devnet (https://api.devnet.solana.com)'
testnet\t'Solana Testnet (https://api.testnet.solana.com)'"
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s m -l manifest-file-path -d 'Path to the runbook manifest' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s r -l runbook -d 'Runbook ID to execute after startup' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s i -l runbook-input -d 'Provide an input file to runbook execution' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l artifacts-path -d 'Directory containing .so program artifacts' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l anchor-test-config-path -d 'Anchor Test.toml file to inspect' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s a -l airdrop -d 'Pubkey to airdrop SOL to at startup' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s k -l airdrop-keypair-path -d 'Keypair path whose pubkey should receive an airdrop' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s q -l airdrop-amount -d 'Quantity of lamports to airdrop to each address on startup. Set to 0 to skip startup airdrops entirely. Values greater than 0 but below the rent-exempt minimum are rejected and result in airdrops being skipped' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l snapshot -d 'JSON account snapshot to preload' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l db -d 'Database connection URL for persistent Surfnet state' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l surfnet-id -d 'Storage namespace for this Surfnet instance' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s s -l studio-port -d 'Bind Studio to this port' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s t -l slot-time -d 'Slot time in milliseconds' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s b -l block-production-mode -d 'Block production mode' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s f -l feature -d 'Enable an SVM feature by pubkey' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l disable-feature -d 'Disable an SVM feature by pubkey' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s g -l geyser-plugin-config -d 'Geyser plugin config file to load' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s c -l max-profiles -d 'Transaction profiles to retain in memory' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l log-bytes-limit -d 'Maximum bytes stored for each transaction log' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s l -l log-level -d 'Simnet log level' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l log-path -d 'Directory for simnet logs' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s d -l subgraph-db -d 'Deprecated; accepted for backward compatibility' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l offline -d 'Run without a remote RPC datasource'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l no-deploy -d 'Disable automatic program deployments'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s y -l yes -d 'Skip runbook generation prompts'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l watch -d 'Watch programs in your artifacts folder (default: `target/deploy`), and automatically re-execute the deployment runbook when the `.so` files change. (eg. surfpool start --watch)'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l legacy-anchor-compatibility -d 'Use defaults suited for legacy Anchor test suites'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l no-tui -d 'Print logs instead of launching the terminal UI'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l no-studio -d 'Disable Surfpool Studio'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l daemon -d 'Run Surfpool as a background process'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l ci -d 'Use settings suitable for CI'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l features-all -d 'Enable all SVM features from agave-feature-set'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l skip-signature-verification -d 'Skip transaction signature verification'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l skip-blockhash-check -d 'Skip transaction blockhash validation'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -l disable-instruction-profiling -d 'Disable instruction profiling'
complete -c surfpool -n "__fish_surfpool_using_subcommand start" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c surfpool -n "__fish_surfpool_using_subcommand completions" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s m -l manifest-file-path -d 'Path to the runbook manifest' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l output-json -d 'Print or write runbook outputs as JSON' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l output -d 'Print one named output at the end of execution' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s p -l port -d 'Set the port for hosting the web UI' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s i -l ip -d 'Set the port for hosting the web UI' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l env -d 'Environment from txtx.yml to use' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l input -d 'Input file to use for batch processing' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s l -l log-level -d 'Runbook execution log level' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l log-path -d 'Directory for runbook execution logs' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s u -l unsupervised -d 'Execute without the supervisor UI'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s b -l browser -d 'Execute with supervision in the browser UI'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s t -l terminal -d 'Execute with supervision in the terminal console'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -l explain -d 'Explain how the runbook will execute'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s f -l force -d 'Ignore cached execution state'
complete -c surfpool -n "__fish_surfpool_using_subcommand run" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c surfpool -n "__fish_surfpool_using_subcommand ls" -s m -l manifest-file-path -d 'Path to the runbook manifest' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand ls" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand mcp" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand update" -s v -l version -d 'To update to a specific version instead of the latest' -r
complete -c surfpool -n "__fish_surfpool_using_subcommand update" -s y -l yes -d 'Flag to skip confirmation prompt'
complete -c surfpool -n "__fish_surfpool_using_subcommand update" -s h -l help -d 'Print help'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls mcp update help" -f -a "start" -d 'Start a local Surfnet'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls mcp update help" -f -a "completions" -d 'Generate shell completion scripts'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls mcp update help" -f -a "run" -d 'Execute a runbook'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls mcp update help" -f -a "ls" -d 'List runbooks in the current workspace'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls mcp update help" -f -a "mcp" -d 'Start the Surfpool MCP server'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls mcp update help" -f -a "update" -d 'Update Surfpool to the latest version'
complete -c surfpool -n "__fish_surfpool_using_subcommand help; and not __fish_seen_subcommand_from start completions run ls mcp update help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
