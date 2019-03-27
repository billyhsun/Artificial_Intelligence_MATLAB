classdef DoubleQueue < handle
    properties ( Access = private )
        elements
        nextInsert
        nextRemove
    end

    properties ( Dependent = true )
        NumElements
    end

    methods
        function obj = DoubleQueue
            obj.elements = cell(1, 10);
            obj.nextInsert = 1;
            obj.nextRemove = 1;
        end
        function add( obj, el )
            % Adds to the 'bottom' of the queue
            if obj.nextInsert == length( obj.elements )
                obj.elements = [ obj.elements, cell( 1, length( obj.elements ) ) ];
            end
            obj.elements{obj.nextInsert} = el;
            obj.nextInsert = obj.nextInsert + 1;
        end
        function el = pop( obj )
            % Pop the top of the DoubleQueue like a stack (LIFO behaviour)
            if obj.isEmpty()
                error( 'DoubleQueue is empty' );
            end
            el = obj.elements{ obj.nextInsert - 1 };
            obj.elements{ obj.nextInsert - 1} = [];
            obj.nextInsert = obj.nextInsert - 1;
            % Add trimming of stack if necessary
            
        end
        function el = remove( obj )
            % Remove and return the bottom element in a FIFO queue fashion
            if obj.isEmpty()
                error( 'DoubleQueue is empty' );
            end
            el = obj.elements{ obj.nextRemove };
            obj.elements{ obj.nextRemove } = [];
            obj.nextRemove = obj.nextRemove + 1;
            % Trim "elements"
            if obj.nextRemove > ( length( obj.elements ) / 2 )
                ntrim = fix( length( obj.elements ) / 2 );
                obj.elements = obj.elements( (ntrim+1):end );
                obj.nextInsert = obj.nextInsert - ntrim;
                obj.nextRemove = obj.nextRemove - ntrim;
            end
        end
        function el = peek_fifo( obj )
            % Return the bottom element (like remove) without removing it 
            if obj.isEmpty()
                error( 'DoubleQueue is empty' );
            end
            el = obj.elements{ obj.nextRemove };
        end
        function el = get(obj, state)
            % Return the first element with state==state
            % Returns [] if the element is not found
            for idx=obj.nextRemove:(obj.nextInsert-1)
                if isempty(obj.elements{idx})
                    el = [];
                    return;
                end
                if obj.elements{idx}.state == state
                    el = obj.elements{idx};
                    return
                end
            end
            el = [];
        end
        function tf = isEmpty( obj )
            tf = ( obj.nextRemove >= obj.nextInsert );
        end
        function n = get.NumElements( obj )
            n = obj.nextInsert - obj.nextRemove;
        end
    end
end