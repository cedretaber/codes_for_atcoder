import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[100][100] AS;

alias Ver = Tuple!(int, "x", int, "y", int, "h");

void main()
{
    foreach (i; 0..100) {
        auto as = readln.split;
        foreach (j, a; as) {
            AS[j][i] = a.to!int;
        }
    }

    Ver[] VS;

    while (VS.length <= 1000) {
        auto v = Ver(0, 0, 0);
        foreach (i; 0..100) {
            foreach (j; 0..100) {
                auto f = true;
                if (i > 0) f &= AS[i][j] > AS[i-1][j];
                if (i < 99) f &= AS[i][j] > AS[i+1][j];
                if (j > 0) f &= AS[i][j] > AS[i][j-1];
                if (j < 99) f &= AS[i][j] > AS[i][j+1];
                if (f && AS[i][j] > v.h) {
                    v.x = j;
                    v.y = i;
                    v.h = AS[i][j];
                }
            }
        }
        if (v.h == 0) break;
        v.h = v.h > 100 ? 100 : v.h;
        VS ~= v;

        foreach (x; 0..v.h) {
            foreach (y; 0..v.h) {
                if (v.h < x + y) continue;
                if (v.x + x < 100 && v.y + y < 100) {
                    auto nh = AS[v.y + y][v.x + x] - v.h + x + y;
                    AS[v.y + y][v.x + x] = nh < 0 ? 0 : nh;
                }
                if (v.x + x < 100 && v.y - y >= 0) {
                    auto nh = AS[v.y - y][v.x + x] - v.h + x + y;
                    AS[v.y - y][v.x + x] = nh < 0 ? 0 : nh;
                }
                if (v.x - x >= 0 && v.y + y < 100) {
                    auto nh = AS[v.y + y][v.x - x] - v.h + x + y;
                    AS[v.y + y][v.x - x] = nh < 0 ? 0 : nh;
                }
                if (v.x - x >= 0 && v.y - y >= 0) {
                    auto nh = AS[v.y - y][v.x - x] - v.h + x + y;
                    AS[v.y - y][v.x - x] = nh < 0 ? 0 : nh;
                }
            }
        }
    }

    writeln(VS.length);
    foreach (v; VS) {
        writefln("%d %d %d", v.x, v.y, v.h);
    }
}