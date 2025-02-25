import { startLocalFunctionsTestnet } from './src/localFunctionsTestnet'
import path from 'path'
import fs from 'fs'
export async function runLocalTestnet() {
  const oldLog = console.log
  // Suppress "Duplicate definition of Transfer" warning message
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  console.log = (...args: any[]) => {
    if (typeof args[0] === 'string') {
      const msg = args.length > 0 ? args[0] : ''
      if (
        msg.includes('Duplicate definition of Transfer') ||
        msg.includes('secp256k1 unavailable, reverting to browser version')
      ) {
        return
      }
    }
    oldLog(...args)
  }
  try {
    const configPath = path.join(process.cwd(), 'don/config.js')
    console.log('Starting local Functions testnet...')
    const testnet = await startLocalFunctionsTestnet(configPath, undefined, 8545, true)
    console.log('DON ID:', testnet.donId)
    console.log('Functions Router Address:', testnet.functionsRouterContract.address)
    console.log(
      'Functions Mock Coordinator Address:',
      testnet.functionsMockCoordinatorContract.address,
    )
    console.log('Link Token Address:', testnet.linkTokenContract.address)
    console.log('Local Functions testnet started successfully')
    const envPath = path.join(process.cwd(), '.env')

    let envContent = ''
    if (fs.existsSync(envPath)) {
      const existingEnv = fs.readFileSync(envPath, 'utf8')
      const envVars = {
        DON_ID: testnet.donId,
        FUNCTIONS_ROUTER_ADDRESS: testnet.functionsRouterContract.address,
        FUNCTIONS_COORDINATOR_ADDRESS: testnet.functionsMockCoordinatorContract.address,
        LINK_TOKEN_ADDRESS: testnet.linkTokenContract.address,
      }

      // Parse existing .env file
      const lines = existingEnv.split('\n')
      const existingVars = new Set()

      // Update existing variables or keep them as is
      for (let i = 0; i < lines.length; i++) {
        const line = lines[i].trim()
        if (!line || line.startsWith('#')) continue

        const match = line.match(/^([^=]+)=(.*)$/)
        if (match) {
          const key = match[1].trim()
          existingVars.add(key)

          // If we have a new value for this key, update it
          if (key in envVars) {
            lines[i] = `${key}=${envVars[key]}`
          }
        }
      }

      // Add any new variables that weren't in the file
      Object.entries(envVars).forEach(([key, value]) => {
        if (!existingVars.has(key)) {
          lines.push(`${key}=${value}`)
        }
      })

      envContent = lines.join('\n')
    } else {
      // If .env doesn't exist, create it with our variables
      envContent = `DON_ID=${testnet.donId}
FUNCTIONS_ROUTER_ADDRESS=${testnet.functionsRouterContract.address}
FUNCTIONS_COORDINATOR_ADDRESS=${testnet.functionsMockCoordinatorContract.address}
LINK_TOKEN_ADDRESS=${testnet.linkTokenContract.address}`
    }

    fs.writeFileSync(envPath, envContent)

    // Keep the process running
    process.on('SIGINT', async () => {
      console.log('Shutting down testnet...')
      await testnet.close()
      process.exit(0)
    })
  } catch (error) {
    console.error(
      'Error starting local Functions testnet, please make sure to run `make fct-anvil`',
    )
    process.exit(1)
  }
}

if (require.main === module) {
  runLocalTestnet()
}
