#!/bin/bash
PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo "{\"password\": \"${PASSWORD}\"}"
