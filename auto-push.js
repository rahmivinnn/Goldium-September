#!/usr/bin/env node

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🚀 Node.js Auto Push Script');

function executeCommand(command) {
    try {
        const output = execSync(command, { encoding: 'utf8', stdio: 'pipe' });
        return { success: true, output };
    } catch (error) {
        return { success: false, error: error.message };
    }
}

function hasChanges() {
    const result = executeCommand('git status --porcelain');
    return result.success && result.output.trim().length > 0;
}

function getCurrentBranch() {
    const result = executeCommand('git branch --show-current');
    return result.success ? result.output.trim() : 'master';
}

function autoPush() {
    console.log('📝 Checking for changes...');
    
    if (!hasChanges()) {
        console.log('✅ No changes detected. Repository is up to date.');
        return;
    }

    const currentBranch = getCurrentBranch();
    console.log(`📍 Current branch: ${currentBranch}`);

    // Add all changes
    console.log('📝 Adding all changes...');
    let result = executeCommand('git add .');
    if (!result.success) {
        console.error('❌ Failed to add changes:', result.error);
        return;
    }

    // Create commit
    const timestamp = new Date().toLocaleString('id-ID');
    const commitMessage = `Auto commit: ${timestamp}`;
    
    console.log(`💾 Creating commit: ${commitMessage}`);
    result = executeCommand(`git commit -m "${commitMessage}"`);
    if (!result.success) {
        console.error('❌ Failed to create commit:', result.error);
        return;
    }

    // Push to current branch
    console.log('🌐 Pushing to GitHub...');
    result = executeCommand(`git push origin ${currentBranch}`);
    if (!result.success) {
        console.error('❌ Failed to push:', result.error);
        return;
    }

    // If not on master, merge to master
    if (currentBranch !== 'master') {
        console.log('🔄 Merging to master branch...');
        
        executeCommand('git checkout master');
        executeCommand(`git merge ${currentBranch}`);
        executeCommand('git push origin master');
        executeCommand(`git checkout ${currentBranch}`);
        
        console.log(`✅ Changes pushed to both ${currentBranch} and master`);
    } else {
        console.log('✅ Changes pushed to master');
    }

    console.log('🎉 Auto push completed successfully!');
    console.log('🌍 Your changes will be automatically deployed to Vercel');
}

// Watch mode
if (process.argv.includes('--watch')) {
    console.log('👀 Starting file watcher...');
    console.log('🛑 Press Ctrl+C to stop');
    
    const chokidar = require('chokidar');
    
    const watcher = chokidar.watch('.', {
        ignored: /(^|[\/\\])\../, // ignore dotfiles
        ignoreInitial: true,
        ignored: [
            'node_modules/**',
            '.git/**',
            '.next/**',
            'dist/**',
            'build/**',
            '**/*.log',
            '**/*.tmp'
        ]
    });

    let timeout;
    
    watcher.on('all', (event, path) => {
        console.log(`📝 File ${event}: ${path}`);
        
        // Debounce: wait 2 seconds after last change
        clearTimeout(timeout);
        timeout = setTimeout(() => {
            console.log('🔄 Changes detected! Starting auto push...');
            autoPush();
            console.log('⏰ Waiting for next changes...\n');
        }, 2000);
    });

} else {
    // Single run mode
    autoPush();
}