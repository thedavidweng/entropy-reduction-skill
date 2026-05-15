#!/bin/bash
# AEO Quick Check — run against a local dev server or deployed URL
# Usage: ./aeo-check.sh [BASE_URL]
# Default: http://localhost:3000

BASE="${1:-http://localhost:3000}"
FAIL=0

pass() { echo "  ✓ $1"; }
fail() { echo "  ✗ $1"; FAIL=$((FAIL + 1)); }

echo "=== AEO Quick Check: $BASE ==="

echo ""
echo "--- Discovery & Crawlability ---"

if curl -sf "$BASE/sitemap.xml" > /dev/null 2>&1; then
  pass "sitemap.xml"
else
  fail "sitemap.xml"
fi

if curl -sf "$BASE/robots.txt" > /dev/null 2>&1; then
  pass "robots.txt"
else
  fail "robots.txt"
fi

LINK=$(curl -sI "$BASE/" 2>/dev/null | grep -i '^Link:')
if echo "$LINK" | grep -qi 'llms.txt'; then
  pass "Link header contains llms.txt"
else
  fail "Link header missing llms.txt"
fi

echo ""
echo "--- LLM Discovery ---"

if curl -sf "$BASE/llms.txt" | head -1 | grep "^# " > /dev/null 2>&1; then
  pass "llms.txt (text/plain with heading)"
else
  fail "llms.txt"
fi

SIZE=$(curl -sf "$BASE/llms-full.txt" | wc -c | tr -d ' ')
if [ "$SIZE" -gt 2000 ] 2>/dev/null; then
  pass "llms-full.txt ($SIZE bytes)"
else
  fail "llms-full.txt (too short or missing)"
fi

if curl -sf "$BASE/index.md" | head -1 | grep "^# " > /dev/null 2>&1; then
  pass "index.md (markdown with heading)"
else
  fail "index.md"
fi

echo ""
echo "--- Agent Views ---"

if curl -sf "$BASE/agent" | jq -e '.identity' > /dev/null 2>&1; then
  pass "/agent (valid JSON)"
else
  fail "/agent (invalid or missing)"
fi

if curl -sf "$BASE/?mode=agent" | grep -q '<h1>' > /dev/null 2>&1; then
  pass "?mode=agent (semantic HTML with h1)"
else
  fail "?mode=agent"
fi

echo ""
echo "--- Structured Data ---"

HTML=$(curl -sf "$BASE/")
if echo "$HTML" | grep -q 'application/ld+json'; then
  pass "JSON-LD present"
else
  fail "JSON-LD missing"
fi

if echo "$HTML" | grep -q '<h1'; then
  pass "h1 in raw HTML"
else
  fail "h1 missing from raw HTML"
fi

echo ""
if [ $FAIL -eq 0 ]; then
  echo "=== ALL CHECKS PASSED ==="
else
  echo "=== $FAIL CHECK(S) FAILED ==="
fi
exit $FAIL
