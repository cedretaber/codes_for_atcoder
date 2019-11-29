import std.stdio, std.string, std.array, std.conv, std.algorithm.iteration, std.functional;

char[54][54] NS;
char[54][54] MS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto n = nm[0];
    auto m = nm[1];

    foreach (i; 0..n) {
        auto line = readln;
        foreach (j, c; line)
            NS[i][j] = c;
    }
    
    foreach (i; 0..m) {
        auto line = readln;
        foreach (j, c; line)
            MS[i][j] = c;
    }
    
    foreach (i; 0..n-m+1) {
        foreach (j; 0..n-m+1) {
            bool check() {
                foreach (ii; 0..m) {
                    foreach (jj; 0..m) {
                        if (NS[i+ii][j+jj] != MS[ii][jj]) return false;
                    }
                }
                return true;
            }
            if (check()) {
                writeln("Yes");
                return;
            }
        }
    }
    writeln("No");
}