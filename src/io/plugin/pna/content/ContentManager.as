/**
 * Gary Paluk - http://www.plugin.io
 * Copyright (c) 2011-2012
 * 
 * Distributed under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */
package io.plugin.pna.content 
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import flash.events.Event;
	
	import flash.utils.Dictionary;
	import io.plugin.core.errors.ObjectDisposedError;
	import io.plugin.core.interfaces.IDisposable
	import io.plugin.pna.IServiceProvider;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class ContentManager implements IDisposable 
	{
		
		//private var mAssets: Dictionary; // this is a list of loaders? Maybe instanciate and map
		private var mAssetCount: int;
		private var mServiceProvider: IServiceProvider;
		private var mRootDirectory: String;
		private var mIsDisposed: Boolean;
		
		public var onProgress: Signal;
		public var onComplete: Signal;
		public var onError: Signal;
		
		private var mLoader: BulkLoader;
		
		public function ContentManager( serviceProvider: IServiceProvider, rootDirectory: String = "" ) 
		{	
			serviceProvider = serviceProvider;
			mRootDirectory = rootDirectory;
			
			mLoader = new BulkLoader( "main" );
			mLoader.logLevel = BulkLoader.LOG_INFO;
			
			mLoader.addEventListener( BulkLoader.COMPLETE, completeHandler );
			mLoader.addEventListener( BulkLoader.PROGRESS, progressHandler );
			mLoader.addEventListener( BulkLoader.ERROR, errorHandler );
			
			onProgress = new Signal(  );
			onComplete = new Signal( );
			onError = new Signal( );
		}
		
		private function progressHandler( e: BulkProgressEvent ): void
		{
			onProgress.dispatch( e );
		}
		
		private function completeHandler( e: Event ): void
		{
			onComplete.dispatch( e );
		}
		
		private function errorHandler( e: Event ): void
		{
			onError.dispatch( e );
		}
		
		public function load( asset: String ): void
		{
			
			if ( isDisposed )
			{
				throw new ObjectDisposedError( );
			}
			
			// concat the path and asset
			var path: String = "";
			if ( mRootDirectory == "" )
			{
				path = asset;
			}
			else
			{
				path = mRootDirectory + "/" + asset;
			}
			
			mLoader.add( path, {id:asset} );
			/*
			var loaderItem: LoaderItem = LoaderFactory.create( type, path, new ImageLoaderVars( { name:asset } ) );
			mLoader.append( loaderItem );
			*/
			
			mLoader.start();
		}
		
		public function get serviceProvider(): IServiceProvider
		{
			return mServiceProvider;
		}
		
		private function set serviceProvider( value: IServiceProvider ): void
		{
			mServiceProvider = value;
		}
		
		public function get rootDirectory(): String
		{
			return mRootDirectory;
		}
		
		public function set rootDirectory( value: String ): void
		{
			if ( mAssetCount > 0 )
			{
				throw new Error( "Cannot change RootDirectory after assets have been loaded." );
			}
			mRootDirectory = value;
		}
		
		public function get isDisposed(): Boolean
		{
			return mIsDisposed;
		}
		
		public function dispose(): void
		{
			if ( !isDisposed )
			{
				
				mLoader.removeAll();
				mLoader.removeEventListener( BulkLoader.COMPLETE, completeHandler );
				mLoader.removeEventListener( BulkLoader.PROGRESS, progressHandler );
				mLoader.removeEventListener( BulkLoader.ERROR, errorHandler );
				
				onProgress.removeAll();
				onProgress = null;
				
				onComplete.removeAll();
				onComplete = null;
				
				onError.removeAll();
				onError = null;
				
				mIsDisposed = true;
				
			}
		}
		
	}

}