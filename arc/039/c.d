import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum O = 10^^5*2+5;
alias P = Tuple!(int, "x", int, "y");

void main()
{
    auto K = readln.chomp.to!int;
    RedBlackTree!int[] hs, ws;
    foreach (_; 0..O*2) {
        hs ~= new RedBlackTree!int();
        ws ~= new RedBlackTree!int();
    }
    hs[O].insert(O-1);
    hs[O].insert(O+1);
    ws[O].insert(O-1);
    ws[O].insert(O+1);

    bool[P] memo;
    memo[P(O, O)] = true;

    int x = O, y = O;
    foreach (i, s; readln.chomp) {
        switch (s) {
            case 'L':
                auto l = ws[y].lowerBound(x).back;
                x = l;
                if (P(l-1, y) !in memo) ws[y].insert(l-1);
                if (P(l, y+1) !in memo) hs[l].insert(y+1);
                if (P(l, y-1) !in memo) hs[l].insert(y-1);
                break;
            case 'R':
                auto r = ws[y].upperBound(x).front;
                x = r;
                if (P(r+1, y) !in memo) ws[y].insert(r+1);
                if (P(r, y+1) !in memo) hs[r].insert(y+1);
                if (P(r, y-1) !in memo) hs[r].insert(y-1);
                break;
            case 'U':
                auto u = hs[x].upperBound(y).front;
                y = u;
                if (P(x, u+1) !in memo) hs[x].insert(u+1);
                if (P(x+1, u) !in memo) ws[u].insert(x+1);
                if (P(x-1, u) !in memo) ws[u].insert(x-1);
                break;
            case 'D':
                auto d = hs[x].lowerBound(y).back;
                y = d;
                if (P(x, d-1) !in memo) hs[x].insert(d-1);
                if (P(x+1, d) !in memo) ws[d].insert(x+1);
                if (P(x-1, d) !in memo) ws[d].insert(x-1);
                break;
            default:
        }
        hs[x].removeKey(y);
        ws[y].removeKey(x);
        memo[P(x, y)] = true;
    }
    writeln(x-O, " ", y-O);
}