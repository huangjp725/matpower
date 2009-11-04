function varargout = runduopf(casename, mpopt, fname, solvedcase)
%RUNDUOPF  Runs a DC optimal power flow with unit-decommitment heuristic.
%
%   Output arguments options:
%
%   results = runduopf(...)
%   [results, success] = runduopf(...)
%   [baseMVA, bus, gen, gencost, branch, f, success, et] = runduopf(...)
%
%   Input arguments options:
%
%   runduopf(casename)
%   runduopf(casename, mpopt)
%   runduopf(casename, mpopt, fname)
%   runduopf(casename, mpopt, fname, solvedcase)
%
%   Runs a DC optimal power flow with a heuristic which allows it to shut down
%   "expensive" generators and optionally returns the solved values in
%   the data matrices, the objective function value, a flag which is true if
%   the algorithm was successful in finding a solution, and the elapsed time
%   in seconds. Alternatively, the solution can be returned as fields in a
%   results struct and an optional success flag.
%
%   All input arguments are optional. If casename is provided it specifies
%   the name of the input data file or struct (see also 'help caseformat' and
%   'help loadcase') containing the opf data. The default value is 'case9'. If
%   the mpopt is provided it overrides the default MATPOWER options vector and
%   can be used to specify the solution algorithm and output options among
%   other things (see 'help mpoption' for details). If the 3rd argument is
%   given the pretty printed output will be appended to the file whose name is
%   given in fname. If solvedcase is specified the solved case will be written
%   to a case file in MATPOWER format with the specified name. If solvedcase
%   ends with '.mat' it saves the case as a MAT-file otherwise it saves it as
%   an M-file.

%   MATPOWER
%   $Id$
%   by Ray Zimmerman, PSERC Cornell
%   Copyright (c) 1996-2008 by Power System Engineering Research Center (PSERC)
%   See http://www.pserc.cornell.edu/matpower/ for more info.

%% default arguments
if nargin < 4
    solvedcase = '';                %% don't save solved case
    if nargin < 3
        fname = '';                 %% don't print results to a file
        if nargin < 2
            mpopt = mpoption;       %% use default options
            if nargin < 1
                casename = 'case9'; %% default data file is 'case9.m'
            end
        end
    end
end

mpopt = mpoption(mpopt, 'PF_DC', 1);
[varargout{1:nargout}] = runuopf(casename, mpopt, fname, solvedcase);