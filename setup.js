const { lstatSync, symlinkSync, renameSync } = require(`fs`)
const { join } = require(`path`)

const files = [{
  source: `zsh/zshrc.zsh`,
  target: `${process.env.HOME}/.zshrc`
}, {
  source: `zsh/functions`,
  target: `${process.env.HOME}/.zsh/functions`
}, {
  source: `zsh/hsh.zsh`,
  target: `${process.env.HOME}/.zshaliases.zsh`
}, {
  source: `gitconfig`,
  target: `${process.env.HOME}/.gitconfig`
}, {
  source: `gitmessage`,
  target: `${process.env.HOME}/.gitmessage`
}, {
  source: `gitignore_global`,
  target: `${process.env.HOME}/.gitignore_global`
}, {
  source: `alias_completions`,
  target: `${process.env.HOME}/.alias_completions`
}, {
  source: `bashrc`,
  target: `${process.env.HOME}/.bashrc`
}, {
  source: `aliases.sh`,
  target: `${process.env.HOME}/.bash_aliases`
}, {
  source: `profile.sh`,
  target: `${process.env.HOME}/.bash_profile`
}, {
  source: `vimrc`,
  target: `${process.env.HOME}/.vimrc`
}]

const withForce = [`-f`, `--force`].some(flag => process.argv.includes(flag))
const exists = []

function _symlinkExists(file) {
  try {
    // use lstat rather than access or stat because there's a chance existing symlinks are broken
    // access and stat error if a symlink exists but is broken, lstat doesn't - the important thing for us to know is that the symlink exists
    lstatSync(file)
    return true
  } catch (err) {
    return false
  }
}

function main() {
  try {
    for (const file of files) {
      // check if symlink exists
      const linkExists = _symlinkExists(file.target)

      // if we're not using force then skip adding the symlink
      if (!withForce && linkExists) {
        exists.push(file.target)
        continue
      }

      // if we're not using force and ANY link already exists then skip adding the symlink
      // this is an all or nothing event!
      if (!withForce && exists.length) {
        continue
      }

      // nearly ready to create the symlink - first have to back up any existing links
      // (we don't have to check withForce here because we've already done that)
      if (linkExists) {
        console.log(`Backing up ${file.target}`)
        renameSync(file.target, `${file.target}_bac`)
      }

      // DO IT
      const linkPath = join(__dirname, file.source)
      console.log(`Creating ${file.target} -> ${linkPath}\n`)
      symlinkSync(linkPath, file.target)
    }

    // Moaaaaaaaan
    if (exists.length) {
      console.error(`\x1b[31mThese symlinks already exist: `)
      console.error(`\t${exists.join(`\n\t`)}\n\x1b[0m`)
      console.info(`\x1b[1mRun this script with --force if you want to overwrite them\x1b[0m`)
      process.exit(-1)
    }

    console.log(`\n\nAll done :)`)
    process.exit(0)
  } catch (err) {
    console.error(err)
    process.exit(-1)
  }
}

main()
