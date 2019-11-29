import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int N, K;
int[2000][2000] WS, BS;
int[2000] WCS, WCSR, BCS, BCSR;

void main()
{
    readf("%d %d", &N, &K);
    int x, y;
    char c;
    auto k2 = K*2;
    foreach (_; 0..N) {
        readf(" %d %d %c", &x, &y, &c);
        if (c == 'W') {
            WS[y%k2][x%k2] += 1;
        } else {
            BS[y%k2][x%k2] += 1;
        }
    }

    foreach (i; 0..K) {
        foreach (j; 0..K) {
            WCS[j] += WS[i][j];
            WCS[K+j] += WS[K+i][K+j];
            WCSR[j] += WS[K+i][j];
            WCSR[K+j] += WS[i][K+j];
            BCS[j] += BS[K+i][j];
            BCS[K+j] += BS[i][K+j];
            BCSR[j] += BS[i][j];
            BCSR[K+j] += BS[K+i][K+j];
        }
    }

    auto cur = 0;
    foreach (n; WCS) cur += n;
    foreach (n; BCS) cur += n;

    auto max = cur;
    for (auto i = 0;; ++i) {
        auto tmp = cur;
        foreach (j; 0..K) {
            cur = cur + WCSR[j] + WCSR[K+j] + BCSR[j] + BCSR[K+j] - WCS[j] - WCS[K+j] - BCS[j] - BCS[K+j];
            max = max > cur ? max : cur;
        }
        cur = tmp;
        foreach_reverse (j; 0..K) {
            cur = cur + WCSR[j] + WCSR[K+j] + BCSR[j] + BCSR[K+j] - WCS[j] - WCS[K+j] - BCS[j] - BCS[K+j];
            max = max > cur ? max : cur;
        }
        if (i == K) break;
        cur = tmp;
        foreach (j; 0..K) {
            cur = cur + WS[K+i][j] + WS[i][K+j] + BS[i][j] + BS[K+i][K+j] - WS[i][j] - WS[K+i][K+j] - BS[i][K+j] - BS[K+i][j];
            WCS[j] = WCS[j] + WS[K+i][j] - WS[i][j];
            WCS[K+j] = WCS[K+j] - WS[K+i][K+j] + WS[i][K+j];
            WCSR[j] = WCSR[j] - WS[K+i][j] + WS[i][j];
            WCSR[K+j] = WCSR[K+j] + WS[K+i][K+j] - WS[i][K+j];
            BCS[j] = BCS[j] - BS[K+i][j] + BS[i][j];
            BCS[K+j] = BCS[K+j] + BS[K+i][K+j] - BS[i][K+j];
            BCSR[j] = BCSR[j] + BS[K+i][j] - BS[i][j];
            BCSR[K+j] = BCSR[K+j] - BS[K+i][K+j] + BS[i][K+j];
        }
    }

    writeln(max);
}