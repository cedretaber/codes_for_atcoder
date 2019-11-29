import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto K = readln.chomp.to!int;
    auto xy = readln.split.to!(int[]);
    if (K%2 != (xy[0] + xy[1])%2) {
        writeln(-1);
        return;
    }
    auto X = xy[0] + xy[1];
    auto Y = xy[0] - xy[1];

    int[2][] r;
    if (X.abs <= K && Y.abs <= K) {
        if (X.abs == K || Y.abs == K) {
            r ~= [X, Y];
        } else {
            auto d = K%2 == (Y-K).abs%2 ? 0 : 1;
            auto x = X < 0 ? K-d : -K+d;
            auto y = Y < 0 ? Y+K : Y-K;
            r ~= [x, y];
            r ~= [X < 0 ? X+K : X-K, Y];
            r ~= [X, Y];
        }
    } else {
        int x, y;
        while (x != X || y != Y) {
            if ((x - X).abs <= K && (y - Y).abs <= K) {
                if ((x - X).abs == K || (y - Y).abs == K) {
                } else if (x == X) {
                    r[$-1][0] = X < 0 ? X+K : X-K;
                } else if (Y == 0) {
                    r[$-1][1] = Y < 0 ? Y+K : Y-K;
                } else {
                    r ~= [X < 0 ? x-K : x+K, Y < 0 ? Y+K : Y-K];
                }
                x = X;
                y = Y;
                r ~= [X, Y];
            } else {
                if ((x - X).abs >= K) {
                    x = X < 0 ? x - K : x + K;
                } else {
                    x = X;
                }
                if ((y - Y).abs >= K) {
                    y = Y < 0 ? y - K : y + K;
                } else {
                    y = Y;
                }
                r ~= [x, y];
            }
        }
    }

    writeln(r.length);
    foreach (rr; r) {
        auto x = (rr[0] + rr[1])/2;
        auto y = (rr[0] - rr[1])/2;
        writefln("%d %d", x, y);
    }
}