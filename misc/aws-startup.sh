#!/usr/bin/env bash

cd ~/rinha-de-backend-2025

SESSION_NAME="rinha"

tmux new-session -d -s "$SESSION_NAME"

tmux rename-window -t "$SESSION_NAME:0" 'test'
tmux send-keys -t "$SESSION_NAME:test" 'cd rinha-test' C-m
tmux send-keys -t "$SESSION_NAME:test" './run-tests.sh' C-m


tmux new-window -t "$SESSION_NAME" -n 'editor'
tmux split-window -h 'cd participantes'
tmux send-keys -t "$SESSION_NAME:editor" 'cd participantes' C-m
tmux send-keys -t "$SESSION_NAME:editor" 'ls | wc -l' C-m
tmux send-keys -t "$SESSION_NAME:editor" 'ls */partial-results.json | wc -l' C-m
